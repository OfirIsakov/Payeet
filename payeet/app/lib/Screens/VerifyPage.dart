import 'dart:async';
import 'package:Payeet/Screens/LoginPage.dart';
import 'package:Payeet/UI_Elements/AppButton.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:Payeet/globals.dart';
import 'AppBase.dart';

class VerifyPage extends StatefulWidget {
  final String email;
  final String password;
  final bool isResetPassword;
  VerifyPage(this.email, this.password, this.isResetPassword);
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  // var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  void login() async {
    try {
      await Globals.client.login(widget.email, widget.password);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return AppBase();
        }),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('[${e.codeName}] ${e.message}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void resetPassword() async {
    try {
      await Globals.client
          .resetPassword(widget.email, widget.password, currentText);

      // redirect to the login page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return LoginPage();
        }),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('[${e.codeName}] ${e.message}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void resendCode() async {
    try {
      await Globals.client.resendCode(widget.email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('A new verification code was sent!'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('[${e.codeName}] ${e.message}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    // onTapRecognizer = TapGestureRecognizer()
    //   ..onTap = () {
    //     try {
    //       print("resend");
    //       Globals.client.resendCode(widget.email);
    //     } catch (e) {
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text('[${e.codeName}] ${e.message}'),
    //         backgroundColor: Colors.red,
    //       ));
    //     }
    //   };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        color: Theme.of(context).highlightColor);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 45.0),
              Container(
                height: 200,
                child: SvgPicture.asset(
                  'assets/icon/payeet_full.svg',
                ),
              ),
              SizedBox(height: 45.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Email Verification',
                  style:
                      style.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                    text: "Enter the code sent to ",
                    children: [
                      TextSpan(
                        text: widget.email,
                        style: style.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                    style: style.copyWith(fontSize: 14),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      textStyle: style.copyWith(color: Colors.black),
                      appContext: context,
                      pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold),
                      length: 6,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        return null;
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        selectedColor: Theme.of(context).primaryColor,
                        selectedFillColor: Theme.of(context).accentColor,
                        inactiveColor: Colors.transparent,
                        inactiveFillColor: Colors.white,
                        activeColor: Colors.transparent,
                        activeFillColor:
                            hasError ? Colors.red : Colors.grey[100],
                      ),
                      cursorColor: Theme.of(context).primaryColor,
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Theme.of(context).backgroundColor,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      useHapticFeedback: true,
                      keyboardType: TextInputType.number,
                      onTap: () async {
                        if (hasError) {
                          if(currentText.length == 6) {
                            textEditingController.clear();
                          }
                          hasError = false;
                        }
                      },
                      onCompleted: (v) async {
                        await _verify();
                      },
                      onChanged: (value) {
                        setState(() {
                          hasError = false;
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return false;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill all the cells properly" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: AppButton(
                    text: "VERIFY",
                    clickFunction: () async {
                      await _verify();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Didn't receive the code? ",
                        style: style.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  TextButton(
                    child: Text("RESEND",
                        style: TextStyle(
                            color: Color(0xFF094CA4),
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    onPressed: () {
                      resendCode();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // verify checks if the given code is correct.
  Future _verify() async {
    formKey.currentState.validate();

    try {
      // send the server a verify request.
      await Globals.client.verify(currentText, widget.email);
      setState(() {
        hasError = false;
      });
      if (widget.isResetPassword) {
        resetPassword();
      } else {
        login();
      }
    } catch (e) {
      // display error
      errorController
          .add(ErrorAnimationType.shake); // Triggering error shake animation
      setState(() {
        hasError = true;
      });
    }
  }
}
