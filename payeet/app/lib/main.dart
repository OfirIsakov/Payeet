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
import 'package:Payeet/Screens/FriendsPage.dart';



import 'package:Payeet/globals.dart';

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
          accentColor: Colors.black,
          primarySwatch: createMaterialColor(Colors.white),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          highlightColor: Colors.white,
          bottomAppBarColor: const Color(0xff141414),
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
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
              subtitle1: TextStyle(
                  color: Color(0xff7589a2),
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          //backgroundColor: const Color(0xff2c4260),
          backgroundColor: const Color(0xff121212),
        ),
        theme: ThemeData(
            primarySwatch: createMaterialColor(Colors.black),
            accentColor: Colors.white,
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
      ),
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

  // this will show in the top of every page.
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
