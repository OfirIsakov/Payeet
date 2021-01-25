import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Payeet/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TransferPage extends StatefulWidget {
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(flex: 5, child: Container()),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36.0),
              child: Column(
                children: [
                  Container(
                    child: Consumer(builder: (context, watch, _) {
                      final balance = watch(Globals.balance).state;
                      final formatCurrency =
                          new NumberFormat.simpleCurrency(decimalDigits: 0);
                      return FittedBox(
                        child: Text(
                          "${formatCurrency.format(balance)}",
                          style: Theme.of(context).textTheme.headline1.copyWith(
                              color: Theme.of(context).highlightColor),
                        ),
                      );
                    }),
                  ),
                  MyForm(),
                ],
              ),
            ),
            Expanded(flex: 5, child: Container()),

            //Expanded(child: Container() ,flex: 5,),
            // Expanded(child:  ,flex: 30,),
            // Expanded(
            //   child: Container(),
            //   flex: 20,
            // ),
          ],
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
  final amountControler = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailControler.dispose();
    amountControler.dispose();
    super.dispose();
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        color: Theme.of(context).highlightColor);

    if (emailControler.text == "") {
      emailControler.text = context.read(Globals.transfer_email).state;
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: emailControler,
            style: style,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the recipient email.';
              }
              return null;
            },
          ),

          SizedBox(height: 25.0),

          TextFormField(
            controller: amountControler,
            style: style,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Amount",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the amount you would like to transfer';
              }

              if (!isNumeric(value)) {
                return 'Please enter a number';
              }

              if (num.parse(value) < 0) {
                return 'Amount must be above 0';
              }

              return null;
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 16.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // Validate returns true if the form is valid, or false
          //       // otherwise.
          //       if (_formKey.currentState.validate()) {
          //         // If the form is valid, display a Snackbar.
          //         Scaffold.of(context)
          //             .showSnackBar(SnackBar(content: Text('Processing Data')));
          //       }
          //     },
          //     child: Text('Submit'),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).highlightColor,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    try {
                      setState(() {
                        _loading = true;
                      });
                      await Globals.client.transferBalance(
                          emailControler.text, int.parse(amountControler.text));

                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Transfered successfully'),
                        backgroundColor: Colors.green,
                      ));

                      context.read(Globals.balance).state -=
                          int.parse(amountControler.text);
                      setState(() {
                        context.read(Globals.transfer_email).state = "";

                        _loading = false;
                      });
                    } catch (e) {
                      setState(() {
                        _loading = false;
                      });
                      print(e.runtimeType);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('[${e.codeName}] ${e.message}'),
                        backgroundColor: Colors.red,
                      ));
                    }
                    // If the form is valid, display a Snackbar.
                    // Scaffold.of(context)
                    //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                  }
                },
                child: !_loading
                    ? Text("Transfer",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold))
                    : //CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
                    CupertinoActivityIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
