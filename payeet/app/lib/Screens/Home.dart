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
  int _balance = 0;

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
                  Text(
                    "\$$_balance",
                    style: Theme.of(context).textTheme.bodyText1,
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
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),
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
