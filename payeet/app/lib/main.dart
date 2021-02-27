// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:Payeet/screens/LoginPage.dart';

import 'package:Payeet/globals.dart';
import 'secure_storage.dart';
import 'Screens/AppBase.dart';

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

/// This is the main application widget.
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  bool shouldMoveUser = false;

  @override
  void initState() {
    super.initState();

    Globals.client.loginWithRefresh().then((value) {
      setState(() {
        shouldMoveUser = value;
      });
      SecureStorage.readSecureData('ThemeIndex')
          .then((index) => Globals.updateThemeMode(int.parse(index), context))
          .catchError((e) => print(e));

      // if (shouldMoveUser) {
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    // this gesture detector allows as to click out side the keyboard to dismiss it.
    return GestureDetector(onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild.unfocus();
      }
    }, child: Consumer(builder: (context, watch, _) {
      final theme = watch(Globals.themeMode).state;

      return MaterialApp(
        themeMode: theme,
        // this is the theme of the app.
        darkTheme: ThemeData(
          unselectedWidgetColor: Colors.white,
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
            unselectedWidgetColor: Colors.black,
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
        home: shouldMoveUser ? AppBase() : LoginPage(),
      );
    }));
  }
}
