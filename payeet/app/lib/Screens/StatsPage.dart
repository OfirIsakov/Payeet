import 'dart:async';
import 'dart:math';

import 'package:Payeet/grpc/protos/payeet.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Payeet/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:Payeet/UI_Elements/linechart.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
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

  @override
  void initState() {
    super.initState();

    if (Globals.transHistory.length == 0) {
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

  setSelectedRadio(int val) {
    var now = DateTime.now();

    setState(() {
      context.read(Globals.radioIndex).state = val;
      history = Globals.transHistory;
      if (val == 2) {
        // transactions from last week.
        history = Globals.transHistory.where((element) {
          var date =
              DateTime.fromMillisecondsSinceEpoch(element.time.toInt() * 1000);
          var diff = now.difference(date);
          return diff.inDays >= 0 && diff.inDays <= 7;
        }).toList();
      } else if (val == 3) {
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
        .getTransferHistory(Globals.client.getCachedUserID)
        // .where((i) => i.amount % 2 == 0) // this edits the stream directly.
        .pipe(sc);
  }

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  Widget _makeElement(int index) {
    if (index >= history.length) {
      return null;
    }

    return Card(
        color: Theme.of(context).backgroundColor,
        child: ListTile(
          // leading: CircleAvatar(
          //   backgroundImage: AssetImage('assets/images/avatar.png'),
          // ),
          dense: false,
          enabled: true,
          leading: Icon(
            CupertinoIcons.money_dollar_circle,
            color: Theme.of(context).highlightColor,
            size: 40,
          ),
          title: Text(
            "To ${history[index].receiverMail}\n",
            style: Theme.of(context).textTheme.headline2,
          ),
          subtitle: Text(
            "${readTimestamp(history[index].time.toInt())}",
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
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
          delegate: SliverChildListDelegate([
        BarChartSample2(),
        Row(
          children: [
            Text(
              "Transactions",
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: context.read(Globals.radioIndex).state,
              activeColor: Colors.green,
              onChanged: (val) {
                print("Radio $val");
                setSelectedRadio(val);
              },
            ),
            Radio(
              value: 2,
              groupValue: context.read(Globals.radioIndex).state,
              activeColor: Colors.blue,
              onChanged: (val) {
                print("Radio $val");
                setSelectedRadio(val);
              },
            ),
            Radio(
              value: 3,
              groupValue: context.read(Globals.radioIndex).state,
              activeColor: Colors.red,
              onChanged: (val) {
                print("Radio $val");
                setSelectedRadio(val);
              },
            ),
          ],
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
