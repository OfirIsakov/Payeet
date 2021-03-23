import 'package:Payeet/UI_Elements/AppButton.dart';
import 'package:Payeet/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Payeet/grpc/protos/payeet.pbgrpc.dart';
import 'package:vibration/vibration.dart';
import './StatsPage.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<HistoryResponse> streamController;
  List<HistoryResponse> history = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
    streamController?.close();
    streamController = null;
  }

  @override
  void initState() {
    super.initState();

    if (streamController == null) {
      streamController = StreamController.broadcast();
      streamController.stream.listen((msg) {
        setState(() {
          history.insert(0, msg);
        });
      });
      load(streamController);
    }
  }

  Future<String> _getBalance() async {
    var f = await Globals.client.getBalance();
    await new Future.delayed(const Duration(seconds: 0));
    context.read(Globals.balance).state = int.parse(f.balance);
    return f.balance;
  }

  load(StreamController<HistoryResponse> sc) async {
    Globals.client
        .getFiveFriendsTransfers()
        // .where((i) => i.amount % 2 == 0) // this edits the stream directly.
        .pipe(sc);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        color: Theme.of(context).highlightColor);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Balance",
                    style: style.copyWith(
                        fontWeight: FontWeight.w800, fontSize: 32),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                    child: FutureBuilder<String>(
                      future:
                          _getBalance(), // a previously-obtained Future<String> or null
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        List<Widget> children;
                        if (snapshot.hasData) {
                          children = <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                "\$ ${snapshot.data}",
                                style: style.copyWith(fontSize: 60),
                              ),
                            ),
                          ];
                        } else if (snapshot.hasError) {
                          children = <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                '${snapshot.error.toString().replaceAll(',', '\n')}',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )
                          ];
                        } else {
                          children = <Widget>[
                            SizedBox(
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              width: 60,
                              height: 60,
                            ),
                          ];
                        }
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: children,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(128, 32),
                          topLeft: Radius.elliptical(128, 32),
                        )),
                    child: Column(
                      children: [
                        SizedBox(height: 8.0),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Recent Friends Activities',
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        LimitedBox(
                            maxHeight: 360,
                            child: ListView.builder(
                              itemBuilder: (_, int index) => ListTile(
                                hoverColor: Colors.red,
                                selectedTileColor: Colors.pink,
                                focusColor: Colors.green,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${history[index].senderMail}',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor)),
                                    Text('${history[index].amount}\$',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor))
                                  ],
                                ),
                                // title: Text(
                                //   "${history[index].senderMail} sent ${history[index].amount}\$",
                                //   style: TextStyle(color: Theme.of(context).highlightColor),
                                // ),
                                subtitle: RichText(
                                    text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'to ',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor),
                                    ),
                                    TextSpan(
                                      text: '${history[index].receiverMail}',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                                enabled: true,
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Scaffold(
                                                appBar: AppBar(
                                                  iconTheme: IconThemeData(
                                                      color: Theme.of(context)
                                                          .highlightColor),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .bottomAppBarColor,
                                                  title: Text(
                                                    history[index].senderMail,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .highlightColor),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .backgroundColor,
                                                body: StatsPage(
                                                  transferEmail:
                                                      history[index].senderMail,
                                                ),
                                              )));
                                },
                              ),
                              itemCount: history.length,
                            )),
                        Expanded(
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        32.0, 0.0, 32.0, 16.0),
                                    child: AppButton(
                                      text: "Pay Someone",
                                      icon: Icon(
                                        Icons.payment_rounded,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      clickFunction: () async {
                                        context
                                            .read(Globals.selectedIndex)
                                            .state = 2;
                                      },
                                    ))))
                      ],
                    ))))
      ],
    );
  }
}
