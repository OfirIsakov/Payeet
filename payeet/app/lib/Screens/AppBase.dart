import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Payeet/Screens/StatsPage.dart';
import 'package:Payeet/Screens/TransferPage.dart';
import 'package:Payeet/Screens/FriendsPage.dart';
import 'package:Payeet/globals.dart';
import 'package:Payeet/Screens/settingsPage.dart';
import 'package:Payeet/Screens/Home.dart';
import 'package:Payeet/Screens/UserPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';

//AppBase is the base of the application,
//it has a navigation bar and
class AppBase extends StatefulWidget {
  // this will show in the bottom part of the app.
  @override
  _AppBaseState createState() => _AppBaseState();
}

class _AppBaseState extends State<AppBase> {
  @override
  void initState() {
    super.initState();
    init();
  }

  /// [init] sets values to the globals and starts a timer to refresh the access toekn.
  void init() async {
    // stating a periodic timer to refresh the accsess token in the backround.
    Timer.periodic(Duration(minutes: 5), (timer) async {
      await Globals.client.loginWithRefresh();
    });

    await Globals.client.getFriends();
    await Globals.client.fetchTopUsers();
    await Globals.client.fetchFollowers();
  }

  final navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: "Friends",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.transfer_within_a_station),
      label: "Transfer",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
      label: "Stats",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: "Profile",
    ),
  ];

  final pageNames = ["Overview", "Friends", "Transfer", "Stats", "Profile"];

  @override
  Widget build(BuildContext context) {
    // _widgetOptions holds the pages
    final List<Widget> _widgetOptions = <Widget>[
      HomePage(),
      FriendsPage(),
      TransferPage(),
      StatsPage(),
      UserPage(),
    ];
    void _onItemTapped(int index) {
      context.read(Globals.selectedIndex).state = index;
    }

    return Consumer(builder: (context, watch, _) {
      final index = watch(Globals.selectedIndex).state;
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            pageNames[index],
            style: Theme.of(context).textTheme.headline6,
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: (index == 0
              ? [
                  IconButton(
                      icon: Icon(
                        CupertinoIcons.chat_bubble_text,
                        color: Theme.of(context).highlightColor,
                      ),
                      onPressed: () {})
                ]
              : index == 4
                  ? [
                      IconButton(
                          icon: Icon(
                            Icons.more_horiz,
                            color: Theme.of(context).highlightColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SettingsPage()));
                          }),
                    ]
                  : []),
        ),
        body: Center(
          child: _widgetOptions.elementAt(index),
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          activeColor: Theme.of(context).highlightColor,
          items: navItems,
          currentIndex: index,
          // selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      );
    });
  }
}
