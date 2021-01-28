import 'dart:ffi';

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
  final emailControler = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailControler.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  int index = 1;

  int selected_index = 0;

  bool showCubes = true;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        color: Theme.of(context).highlightColor);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
          // new line
          child: Column(
        children: <Widget>[
          Container(
            child: Consumer(builder: (context, watch, _) {
              final balance = watch(Globals.balance).state;
              final formatCurrency =
                  new NumberFormat.simpleCurrency(decimalDigits: 0);
              return FittedBox(
                child: RichText(
                  text: TextSpan(
                    text: "Balance\n",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).highlightColor,
                        fontSize: 30),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${formatCurrency.format(balance)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).highlightColor,
                            fontSize: 40),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),

          //Expanded(child: Container() ,flex: 5,),
          // Expanded(child:  ,flex: 30,),
          // Expanded(
          //   child: Container(),
          //   flex: 20,
          // ),

          Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0),
                  child: Column(
                    children: [
                      ButtonBar(
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  index = 1;
                                });
                              },
                              child: Text(
                                "Favorites",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Theme.of(context).highlightColor,
                                    fontSize: 20),
                              )),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  index = 0;
                                });
                              },
                              child: Text(
                                "New User",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Theme.of(context).highlightColor,
                                    fontSize: 20),
                              )),
                        ],
                      ),
                      index == 1
                          ? ButtonBar(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showCubes = true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.view_week,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showCubes = false;
                                    });
                                  },
                                  icon: Icon(Icons.list),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  )),

              Padding(
                padding: const EdgeInsets.only(bottom: 36, left: 36, right: 36),
                child: index == 0
                    ? Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: emailControler,
                                  style: style,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0))),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter email.';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 5.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Theme.of(context).highlightColor,
                                    child: MaterialButton(
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          try {
                                            setState(() {
                                              _loading = true;
                                            });

                                            await Globals.client
                                                .addFriend(emailControler.text);
                                            await Globals.client.getUserInfo();

                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text('Added successfully'),
                                              backgroundColor: Colors.green,
                                            ));

                                            setState(() {
                                              _loading = false;
                                            });
                                          } catch (e) {
                                            setState(() {
                                              _loading = false;
                                            });
                                            //print(e.runtimeType);
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  '[${e.codeName}] ${e.message}'),
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                        }
                                      },
                                      child: !_loading
                                          ? Text("Add",
                                              textAlign: TextAlign.center,
                                              style: style.copyWith(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.bold))
                                          : //CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
                                          CupertinoActivityIndicator(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : LimitedBox(
                        maxHeight: 100,
                        child: showCubes
                            ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) => GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text(
                                          'Delete ${Globals.client.getCachedFriends[index]}?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        backgroundColor:
                                            Theme.of(context).backgroundColor,
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              setState(() {
                                                Globals.client.getCachedFriends;
                                              });
                                              Navigator.of(context).pop();
                                              return false;
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Approve'),
                                            onPressed: () async {
                                              try {
                                                await Globals.client
                                                    .removeFriend(Globals.client
                                                            .getCachedFriends[
                                                        index]);
                                                setState(() {
                                                  Globals
                                                      .client.getCachedFriends
                                                      .removeAt(index);
                                                });
                                              } catch (e) {
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      '[${e.codeName}] ${e.message}'),
                                                  backgroundColor: Colors.red,
                                                ));
                                              }

                                              Navigator.of(context).pop();
                                              return true;
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  onTap: () {
                                    setState(() {
                                      print(Globals
                                          .client.getCachedFriends[index]);
                                      //emailControler.text = Globals.client.getCachedFriends[index];
                                      context
                                              .read(Globals.transfer_email)
                                              .state =
                                          Globals
                                              .client.getCachedFriends[index];
                                      selected_index = index;
                                    });
                                    //print("Container clicked");
                                  },
                                  child: SizedBox(
                                    width: 200,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: selected_index == index
                                              ? Colors.cyan
                                              : Theme.of(context)
                                                  .highlightColor,
                                          // border: Border.all(
                                          //   color: Colors.red[500],
                                          // ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // SizedBox(
                                          //   width:
                                          //       MediaQuery.of(context).size.width / 4,
                                          // ),
                                          Container(
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                  'assets/images/avatar.png'),
                                            ),
                                          ),
                                          Stack(
                                            alignment: Alignment.center,
                                            overflow: Overflow.visible,
                                            children: [
                                              RichText(
                                                  text: TextSpan(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                text:
                                                    "${Globals.client.getCachedFriends[index]}\n",
                                              )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                separatorBuilder: (_, index) => VerticalDivider(
                                  width: 20,
                                ),
                                itemCount:
                                    Globals.client.getCachedFriends.length,
                              )
                            : ListView.separated(
                                itemBuilder: (_, index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Dismissible(
                                        confirmDismiss: (direction) async {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            print("transfer to friend.");
                                            context.read(Globals.transfer_email).state =Globals.client.getCachedFriends[index];
                                            
                                            // context
                                            //     .read(Globals.selectedIndex)
                                            //     .state++;

                                            context
                                                    .read(Globals.transfer_email)
                                                    .state =
                                                Globals.client
                                                    .getCachedFriends[index];
                                            selected_index = index;
                                          }

                                          // remove friend.
                                          if (direction ==
                                              DismissDirection.startToEnd) {
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                title: Text(
                                                  'Delete ${Globals.client.getCachedFriends[index]}?',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .backgroundColor,
                                                actions: [
                                                  TextButton(
                                                    child: Text('Cancel'),
                                                    onPressed: () {
                                                      setState(() {
                                                        Globals.client
                                                            .getCachedFriends;
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                      return false;
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Approve'),
                                                    onPressed: () async {
                                                      try {
                                                        await Globals.client
                                                            .removeFriend(Globals
                                                                    .client
                                                                    .getCachedFriends[
                                                                index]);
                                                        setState(() {
                                                          Globals.client
                                                              .getCachedFriends
                                                              .removeAt(index);
                                                        });
                                                      } catch (e) {
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              '[${e.codeName}] ${e.message}'),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ));
                                                      }

                                                      Navigator.of(context)
                                                          .pop();
                                                      return true;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          }

                                          return false;
                                        },
                                        secondaryBackground: Container(
                                          alignment: Alignment.centerRight,
                                          color: Colors.green,
                                          child: Icon(
                                              Icons.transfer_within_a_station),
                                        ),
                                        background: Container(
                                          alignment: Alignment.centerLeft,
                                          color: Colors.red,
                                          child: Icon(
                                              Icons.delete_forever_outlined),
                                        ),
                                        key: ValueKey(Globals
                                            .client.getCachedFriends[index]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                            ),
                                            Stack(
                                              alignment: Alignment.center,
                                              overflow: Overflow.visible,
                                              children: [
                                                Positioned(
                                                  child: Container(
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage: AssetImage(
                                                          'assets/images/avatar.png'),
                                                    ),
                                                  ),
                                                  left: -60,
                                                ),
                                                RichText(
                                                    text: TextSpan(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                                  text:
                                                      "${Globals.client.getCachedFriends[index]}\n",
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            "${Globals.client.getCachedFriends[index]}@email.com",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1),
                                                  ],
                                                )),
                                              ],
                                            ),
                                          ],
                                        ))),
                                separatorBuilder: (_, index) => SizedBox(
                                  height: 10,
                                ),
                                itemCount:
                                    Globals.client.getCachedFriends.length,
                              ),
                      ),
              ),

              //Expanded(flex: 1, child: Container()),

              Padding(
                padding: const EdgeInsets.only(left: 36.0, right: 36.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyForm(),
                    ]),
              ),
            ],
          ),

          //Expanded(flex: 1, child: Container()),
        ],
      )),
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

    emailControler.text = context.read(Globals.transfer_email).state;
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
