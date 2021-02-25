import 'package:Payeet/Screens/FollowersPage.dart';
import 'package:Payeet/Screens/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Payeet/globals.dart';
import 'package:Payeet/UI_Elements/confirm.dart';

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
          Text(
              "${Globals.client.getCachedFirstName} ${Globals.client.getCachedLastName}",
              style: Theme.of(context).textTheme.bodyText1),

          Text(Globals.client.getCachedUserID,
              style: Theme.of(context).textTheme.subtitle1),

          GestureDetector(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("Followers", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).highlightColor),),
                  Text("${Globals.client.getCachedFollowers.length}", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).highlightColor),),
                ],
              ),
              Column(
                children: [
                  Text("Following",style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).highlightColor),),
                  Text("${Globals.client.getCachedFriends.length}", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).highlightColor),),
                ],
              )
            ],
          ),
          onTap: () async{
            await Globals.client.fetchFollowers();
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FollowersPage()));
          },
          ),

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
                            Globals.client.secureStorage
                                .deleteSecureData('refreshToken');
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return LoginPage();
                              }),
                            );
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
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold))
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
