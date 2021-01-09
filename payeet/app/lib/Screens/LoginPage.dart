import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';

import 'package:Payeet/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();

  bool _loading = false;

  Future<Void> _handleSignIn(String email, String password) async {
    print('sendLoginRequest(Correct)...');
    var user = await Globals.client.login(email, password);
    print('Login response recieved:\n${user}');

    Globals.client.accessToken = user.accessToken;
    Globals.client.refreshToken = user.refreshToken;
    Globals.client.createAuthenticatedClient(); 

  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Theme.of(context).highlightColor);
    final emailField = TextField(
      
      obscureText: false,
      style: style,
      controller: emailControler,
      
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      
      obscureText: true,
      style: style,
      controller: passwordControler,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),)),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          // return showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       // Retrieve the text the that user has entered by using the
          //       // TextEditingController.
          //       content: Text(emailControler.text + '\n' + passwordControler.text),
          //     );
          //   },
          // );

          //context.read(Globals.email).state = emailControler.text;
          
          setState(() {
            _loading = true;
          });
          
          _handleSignIn(emailControler.text, passwordControler.text)
              .whenComplete(() => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return AppBase();
                    }),
                  ));
        },
        child: !_loading
            ? Text("Login",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold))
            : //CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
            CupertinoActivityIndicator(
              
            ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/payeet.jpeg')),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
