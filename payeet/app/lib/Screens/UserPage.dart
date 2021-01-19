import 'package:Payeet/Screens/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Payeet/globals.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        color: Theme.of(context).highlightColor);
    // return CustomScrollView(
    //   slivers: <Widget>[

    //     //

    //   ],
    // );
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          CircleAvatar(
            radius: 51,
            backgroundColor: Theme.of(context).highlightColor,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          ),
          Text("${Globals.client.getCachedFirstName} ${Globals.client.getCachedLastName}", style: Theme.of(context).textTheme.bodyText1),

          Text(Globals.client.getCachedUserID,style: Theme.of(context).textTheme.subtitle1),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).highlightColor,
              child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).accentColor,
                      ),
                      Text("Logout",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Theme.of(context).accentColor, fontWeight: FontWeight.bold))
                    ],
                  )),
            ),
          ),

          // CloseButton(
          //   onPressed: () {
          //     Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(builder: (context) {
          //         return LoginPage();
          //       }),
          //     );
          //   },
          //   color: Colors.red,
          // ),
        ],
      ),
    );
  }
}
