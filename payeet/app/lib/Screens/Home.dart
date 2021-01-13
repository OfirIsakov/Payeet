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
    await new Future.delayed(const Duration(seconds : 2));
    return f.balance;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Balance",
                    style: Theme.of(context).textTheme.bodyText1,
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
                              child: Text('\$ ${snapshot.data}'),
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
                              child: Text('Error: ${snapshot.error}'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  color: Theme.of(context).bottomAppBarColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)),
                  textColor: Theme.of(context).highlightColor,
                  onPressed: () {
                    context.read(Globals.selectedIndex).state = 2;
                  },
                  child: Text(
                    "Transfer",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ])),
      ],
    );
  }
}
