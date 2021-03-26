import 'dart:async';
import 'package:Payeet/grpc/protos/payeet.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Payeet/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:Payeet/UI_Elements/chart.dart';

class StatsPage extends StatefulWidget {
  final String transferEmail;

  StatsPage({Key key, this.transferEmail}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  final emailControler = TextEditingController();
  StreamController<HistoryResponse> streamController;
  List<HistoryResponse> history = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
    emailControler.dispose();
    streamController?.close();
    streamController = null;
  }

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 3, vsync: this);

    if (Globals.transHistory.length == 0 || streamController == null) {
      streamController = StreamController.broadcast();
      streamController.stream.listen((msg) {
        setState(() {
          history.insert(0, msg);
        });
      });
      load(streamController);
      Globals.transHistory = history;
    }

    history = Globals.transHistory;
  }

  setSelectedFilter(int val) {
    var now = DateTime.now();

    setState(() {
      context.read(Globals.radioIndex).state = val;
      history = Globals.transHistory;
      if (val == 1) {
        // transactions from last week.
        history = Globals.transHistory.where((element) {
          var date =
              DateTime.fromMillisecondsSinceEpoch(element.time.toInt() * 1000);
          var diff = now.difference(date);
          return diff.inDays >= 0 && diff.inDays <= 7;
        }).toList();
      } else if (val == 2) {
        // transactions from today
        history = Globals.transHistory.where((element) {
          var date =
              DateTime.fromMillisecondsSinceEpoch(element.time.toInt() * 1000);
          var diff = now.difference(date);
          return diff.inDays >= 0 && diff.inDays <= 1;
        }).toList();
      } else if (false) {}
    });
  }

  load(StreamController<HistoryResponse> sc) async {
    Globals.client
        .getTransferHistory(widget.transferEmail)
        // .where((i) => i.amount % 2 == 0) // this edits the stream directly.
        .pipe(sc);
  }

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  Widget _makeElement(int index) {
    if (index >= history.length) {
      return null;
    }

    bool income = history[index].receiverMail == widget.transferEmail;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn =
        (context.read(Globals.themeMode).state == ThemeMode.dark ||
            brightness == Brightness.dark);
    var format = DateFormat('d/M/y');
    return Card(
        color: Theme.of(context).backgroundColor,
        child: ListTile(
          // leading: CircleAvatar(
          //   backgroundImage: AssetImage('assets/images/avatar.png'),
          // ),
          dense: false,
          enabled: true,
          leading: income
              ? Icon(
                  CupertinoIcons.money_dollar_circle,
                  color: Theme.of(context).highlightColor,
                  size: 40,
                )
              : SizedBox(
                  child: Image(
                      image: darkModeOn
                          ? AssetImage('assets/images/inoutwhite.png')
                          : AssetImage('assets/images/inoutblack.png')),
                  height: 40,
                  width: 40,
                ),
          title: Text(
            income
                ? "From ${history[index].senderMail}\n"
                : "To ${history[index].receiverMail}\n",
            style: Theme.of(context).textTheme.headline2,
          ),

          subtitle: Text(
            "${format.format(DateTime.fromMillisecondsSinceEpoch(history[index].time.toInt() * 1000))}  ➤ ${readTimestamp(history[index].time.toInt())}",
            style: TextStyle(color: Theme.of(context).highlightColor),
          ),
          trailing: Text(
            "${history[index].amount}",
            style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 20),
          ),

          //isThreeLine: true,
        ));
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = diff.inDays.toString() +
          ((diff.inDays == 1) ? ' DAY AGO' : ' DAYS AGO');
    } else {
      time = (diff.inDays / 7).floor().toString() +
          (((diff.inDays / 7).floor() == 1) ? ' WEEK AGO' : ' WEEKS AGO');
    }

    return time;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
          delegate: SliverChildListDelegate([
        LimitedBox(
          maxHeight: 300,
          child: Chart1(
            transferEmail: widget.transferEmail,
            transHistory: history,
          ),
        ),
        TabBar(
          onTap: (val) {
            setSelectedFilter(val);
          },
          unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
          labelColor: Theme.of(context).primaryColor,
          indicatorColor: Theme.of(context).primaryColor,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
          tabs: [
            Tab(
              text: "All Time",
            ),
            Tab(
              text: "Week",
            ),
            Tab(
              text: "Day",
            )
          ],
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ])),
      SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => _makeElement(index),
        ),
      ),
    ]);
  }
}
