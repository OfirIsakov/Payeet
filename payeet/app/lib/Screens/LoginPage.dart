import 'package:Payeet/Screens/RegisterPage.dart';
import 'package:Payeet/Screens/VerifyPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:Payeet/globals.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'AppBase.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
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
                  child: SvgPicture.asset(
                    'assets/icon/payeet_icon.svg',
                  ),
                ),
                SizedBox(height: 45.0),
                MyForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailControler.dispose();
    passwordControler.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        color: Theme.of(context).highlightColor);

    void login() async {
      if (_formKey.currentState.validate()) {
        try {
          setState(() {
            _loading = true;
          });

          await Globals.client
              .login(emailControler.text, passwordControler.text);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return AppBase();
            }),
          );
        } on GrpcError catch (e) {
          setState(() {
            _loading = false;
          });

          if (e.code == 7) {
            // permission denied
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return VerifyPage(emailControler.text, passwordControler.text);
              }),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('[${e.codeName}] ${e.message}'),
              backgroundColor: Colors.red,
            ));
          }
        }
      }
    }

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                controller: emailControler,
                style: style,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    hintStyle: style,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).highlightColor,
                            width: 2.5),
                        borderRadius: BorderRadius.circular(32.0))),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25.0),
              TextFormField(
                autocorrect: false,
                textInputAction: TextInputAction.send,
                onFieldSubmitted: (s) {
                  login();
                },
                controller: passwordControler,
                style: style,
                obscureText: true,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Password",
                    hintStyle: style,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).highlightColor,
                            width: 2.5),
                        borderRadius: BorderRadius.circular(32.0))),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff01A0C7),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      login();
                    },
                    child: !_loading
                        ? Text("Login",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                        : CupertinoActivityIndicator(),
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  style: style,
                  children: <TextSpan>[
                    TextSpan(text: 'Not registered? '),
                    TextSpan(
                        text: 'Register',
                        style: style.copyWith(
                            color: Colors.blue[400],
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          }),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
