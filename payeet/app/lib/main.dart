// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:Payeet/Screens/Home.dart';
import 'package:Payeet/Screens/UserPage.dart';
import 'package:Payeet/screens/LoginPage.dart';
import 'package:Payeet/Screens/StatsPage.dart';
import 'package:Payeet/Screens/TransferPage.dart';


import 'package:Payeet/globals.dart';


void main() {
  Globals.client.createUnauthenticatedClient();
  runApp(
    ProviderScope(child: MyApp()),
  );
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        highlightColor: Colors.white,
        bottomAppBarColor: const Color(0xff162130),
        textTheme: TextTheme(
            headline2: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            headline6: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            bodyText1: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w300, color: Colors.white),
            subtitle1: TextStyle(
                color: Color(0xff7589a2),
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        backgroundColor: const Color(0xff2c4260),
      ),
      theme: ThemeData(
          highlightColor: Colors.black,
          bottomAppBarColor: Colors.white,
          textTheme: TextTheme(
              headline2: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              headline6: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              bodyText1: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
              subtitle1: TextStyle(
                  color: Color(0xff7589a2),
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          backgroundColor: Colors.white),
      home: LoginPage(),
    );
  }
}

//AppBase is the base of the application,
//it has a navigation bar and
class AppBase extends StatelessWidget {
  // this will show in the bottom part of the app.
  final navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.transfer_within_a_station),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
    ),
  ];

  // this will show in the top of every page.
  final pageNames = ["Overview", "Search", "Transfer", "Stats", "Profile"];

  @override
  Widget build(BuildContext context) {
    // _widgetOptions holds the pages
    final List<Widget> _widgetOptions = <Widget>[
      HomePage(),
      Text(
        'Index 2: search',
        style: Theme.of(context).textTheme.headline2,
      ),
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
                        color:  Theme.of(context).highlightColor,
                      ),
                      onPressed: () {})
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
