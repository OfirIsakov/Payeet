import 'dart:ffi';

import 'package:Payeet/Screens/LoginPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import '../main.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:Payeet/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    confirmEmailController.dispose();
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

    return Form(
        key: _formKey,
        child: Container(
            child: Padding(
                padding:
                    EdgeInsets.only(left: 36, right: 36, bottom: 36, top: 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        autocorrect: false,
                        controller: firstNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        style: style,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "First Name",
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
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        controller: lastNameController,
                        style: style,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Last Name",
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
                      SizedBox(height: 10.0),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        controller: confirmEmailController,
                        style: style,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Confirm Email",
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
                          if (value != emailController.text) {
                            return 'No no, email not match';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 25.0),
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
                              if (_formKey.currentState.validate()) {
                                try {
                                  setState(() {
                                    _loading = true;
                                  });
                                  print(firstNameController.text);
                                  print(lastNameController.text);
                                  print(emailController.text);
                                  print(passwordController.text);
                                  await Globals.client.register(
                                      firstNameController.text,
                                      lastNameController.text,
                                      emailController.text,
                                      passwordController.text);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                      return LoginPage();
                                    }),
                                  );
                                } catch (e) {
                                  setState(() {
                                    _loading = false;
                                  });

                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content:
                                        Text('[${e.codeName}] ${e.message}'),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }
                            },
                            child: !_loading
                                ? Text("Register",
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
                            TextSpan(text: 'Already registered? '),
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
