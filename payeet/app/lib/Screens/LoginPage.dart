import 'package:Payeet/Screens/RegisterPage.dart';
import 'package:Payeet/Screens/ResetPasswordPage.dart';
import 'package:Payeet/Screens/VerifyPage.dart';
import 'package:Payeet/UI_Elements/AppButton.dart';
import 'package:Payeet/UI_Elements/AppInputField.dart';
import 'package:Payeet/grpc/protos/payeet.pb.dart';
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
                  height: 200,
                  child: SvgPicture.asset(
                    'assets/icon/PayeetLogoNoBackground.svg',
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
                return VerifyPage(
                    emailControler.text, passwordControler.text, false);
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
              AppInputField(
                placeholderText: 'Email',
                title: 'Email Address',
                controller: emailControler,
                textInputAction: TextInputAction.next,
                inputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25.0),
              AppInputField(
                placeholderText: 'Password',
                title: 'Password',
                obscureText: true,
                controller: passwordControler,
                textInputAction: TextInputAction.send,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5.0),
              Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      style: style,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Forgot password?',
                            style: style.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: style.fontSize / 1.5),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ResetPasswordPage()),
                                );
                              }),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff01A0C7),
                  child: AppButton(
                    text: "Login",
                    isLoading: _loading,
                    clickFunction: () async {
                      login();
                    },
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                      child: RichText(
                    text: TextSpan(
                      style: style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Not registered? ',
                          style: style.copyWith(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w700,
                              fontSize: style.fontSize / 1.5),
                        ),
                        TextSpan(
                            text: 'Register',
                            style: style.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: style.fontSize / 1.5),
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
                  ))),
            ],
          ),
        ));
  }
}
