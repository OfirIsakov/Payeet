import 'package:Payeet/Screens/LoginPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Payeet/globals.dart';
import 'package:grpc/grpc.dart';

import 'AppBase.dart';
import 'VerifyPage.dart';


class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
        SizedBox(height: 45.0),
        Container(
          height: 100,
          child: SvgPicture.asset(
            'assets/icon/payeet_icon.svg',
          ),
        ),
        SizedBox(height: 45.0),
        MyForm(),
      ]))),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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

    void resetPassword() async {
      if (_formKey.currentState.validate()) {
        try {
          setState(() {
            _loading = true;
          });

          await Globals.client
              .resetPassword(emailController.text, passwordController.text, '');

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return VerifyPage(emailController.text, passwordController.text, true);
            }),
          );
        } on GrpcError catch (e) {
          setState(() {
            _loading = false;
          });

          if (e.code == 14) {
            // unavailable - probably hes on cooldown, let him in the verify page
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return VerifyPage(emailController.text, passwordController.text, true);
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
        child: Container(
            child: Padding(
                padding:
                    EdgeInsets.only(left: 36, right: 36, bottom: 36, top: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        controller: emailController,
                        style: style,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                      SizedBox(height: 20.0),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        controller: passwordController,
                        style: style,
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                      SizedBox(height: 10.0),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        controller: confirmPasswordController,
                        style: style,
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Confirm Password",
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
                          if (value != passwordController.text) {
                            return 'No no, password not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Card(
                          color: Theme.of(context).backgroundColor,
                          shadowColor: Theme.of(context).highlightColor,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                style: style.copyWith(fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(text: 'Password Requirements:\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                  TextSpan(text: '∙ minumum length of 5 characters\n'),
                                  TextSpan(text: '∙ password must contains at least 1 special character ~<=>+-@!#\$%^&* \n'),
                                  
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff01A0C7),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () async {
                              resetPassword();
                            },
                            child: !_loading
                                ? Text("Request Reset",
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
                            TextSpan(text: 'Suddenly remembered?? '),
                            TextSpan(
                                text: 'Login',
                                style: style.copyWith(
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  }),
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
