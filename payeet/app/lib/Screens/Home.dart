import 'package:Payeet/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:vibration/vibration.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> _getBalance() async {
    var f = await Globals.client.getBalance();
    await new Future.delayed(const Duration(seconds: 0));
    context.read(Globals.balance).state = int.parse(f.balance);
    return f.balance;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        color: Theme.of(context).highlightColor);

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Balance",
                      style: style,
                    ),

                    // Text(
                    //   "\$${_getBalance()}",
                    //   style: Theme.of(context).textTheme.bodyText1,
                    // ),

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
                                child: Text("\$ ${snapshot.data} ", style: style.copyWith(fontSize: 60),),
                              ),
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                                size: 60,
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
                                child: CircularProgressIndicator(),
                                width: 60,
                                height: 60,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Awaiting result...'),
                              )
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
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 100),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).highlightColor,
              child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    context.read(Globals.selectedIndex).state = 2;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.payment_rounded,
                        color: Theme.of(context).accentColor,
                      ),
                      Text("Pay",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold))
                    ],
                  )),
            ),
          ),
        ])),
      ],
    );
  }
}
