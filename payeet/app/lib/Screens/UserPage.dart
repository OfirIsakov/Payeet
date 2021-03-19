import 'package:Payeet/Screens/FollowersPage.dart';
import 'package:Payeet/Screens/LoginPage.dart';
import 'package:Payeet/UI_Elements/AppButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Payeet/globals.dart';
import 'package:Payeet/UI_Elements/confirm.dart';
import 'package:Payeet/secure_storage.dart';
import 'package:Payeet/grpc/helpers.dart';

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
              backgroundImage: NetworkImage(Globals.client
                  .getCachedProfileImages[Globals.client.getCachedImageID]),
            ),
          ),
          Text(
              "${Globals.client.getCachedFirstName.capitalize()} ${Globals.client.getCachedLastName.capitalize()}",
              style: Theme.of(context).textTheme.bodyText1),

          Text(Globals.client.getCachedMail,
              style: Theme.of(context).textTheme.subtitle1),

          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Followers",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).highlightColor),
                    ),
                    Text(
                      "${Globals.client.getCachedFollowers.length}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).highlightColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Following",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).highlightColor),
                    ),
                    Text(
                      "${Globals.client.getCachedFriends.length}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).highlightColor),
                    ),
                  ],
                )
              ],
            ),
            onTap: () async {
              await Globals.client.fetchFollowers();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => FollowersPage()));
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).highlightColor,
              child: AppButton(
                text: "Logout",
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).accentColor,
                ),
                clickFunction: () async {
                  showDialog(
                    context: context,
                    builder: (_) => ConfirmDialog(
                        danger: true,
                        title: 'Log out?',
                        content: Text("Are you sure you want to log out?"),
                        cancelFunction: () {
                          Navigator.of(context).pop();
                          return false;
                        },
                        actionText: Text('logout'),
                        actionFunction: () async {
                          SecureStorage.deleteSecureData('refreshToken');
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }),
                          );
                        }),
                  );
                },
              ),
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
