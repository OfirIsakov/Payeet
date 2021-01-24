import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Payeet/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final emailControler = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailControler.dispose();
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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Add friend",
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36.0),
              child: Column(
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
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 5.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(30.0),
                            color: Theme.of(context).highlightColor,
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

                                    await Globals.client
                                        .addFriend(emailControler.text);
                                    await Globals.client.getUserInfo();

                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Added successfully'),
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
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                          Text('[${e.codeName}] ${e.message}'),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                  // If the form is valid, display a Snackbar.
                                  // Scaffold.of(context)
                                  //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                                }
                              },
                              child: !_loading
                                  ? Text("Add",
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
                  ),
                ],
              ),
            ),
            Text(
              "My friends",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline6,
            ),
            // LimitedBox(
            //   maxHeight: 200,
            //   child: FutureBuilder(
            //       future: Globals.client.getUserInfo(),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.done) {
            //           if (snapshot.data == null) {
            //             return Text(
            //               "ERROR",
            //               style: Theme.of(context).textTheme.bodyText1,
            //             );
            //           }

            //           return CustomScrollView(slivers: <Widget>[
            //             SliverFixedExtentList(
            //               itemExtent: 75.0,
            //               delegate: SliverChildBuilderDelegate(
            //                 (BuildContext context, int index) {
            //                   return Padding(
            //                       padding: const EdgeInsets.only(bottom: 5),
            //                       child: Row(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           Stack(
            //                             alignment: Alignment.center,
            //                             overflow: Overflow.visible,
            //                             children: [
            //                               Positioned(
            //                                 child: Container(
            //                                   child: CircleAvatar(
            //                                     radius: 20,
            //                                     backgroundImage: AssetImage(
            //                                         'assets/images/avatar.png'),
            //                                   ),
            //                                 ),
            //                                 left: -60,
            //                               ),
            //                               RichText(
            //                                   text: TextSpan(
            //                                 style: Theme.of(context)
            //                                     .textTheme
            //                                     .headline2,
            //                                 text:
            //                                     "${snapshot.data.friends[index]}\n",
            //                                 children: <TextSpan>[
            //                                   TextSpan(
            //                                       text:
            //                                           "${snapshot.data.friends[index]}@email.com",
            //                                       style: Theme.of(context)
            //                                           .textTheme
            //                                           .subtitle1),
            //                                 ],
            //                               )),
            //                             ],
            //                           ),
            //                           SizedBox(),
            //                         ],
            //                       ));
            //                 },
            //                 childCount: snapshot.data.friends.length,
            //               ),
            //             )
            //           ]);
            //         } else {
            //           return CircularProgressIndicator();
            //         }
            //       }),

            //   //Expanded(child: Container() ,flex: 5,),
            //   // Expanded(child:  ,flex: 30,),
            //   // Expanded(
            //   //   child: Container(),
            //   //   flex: 20,
            //   // ),
            // ),

            LimitedBox(
              maxHeight: 200,
              child: CustomScrollView(slivers: <Widget>[
                SliverFixedExtentList(
                  itemExtent: 75.0,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Dismissible(
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  print("transfer to friend.");

                                  context.read(Globals.selectedIndex).state++;
                                  //return false;
                                }

                                // remove friend.
                                if (direction == DismissDirection.startToEnd) {
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
                                          onPressed: () {
                                            setState(() {
                                              Globals.client.removeFriend(
                                                  Globals.client
                                                      .getCachedFriends[index]);

                                              Globals.client.getCachedFriends
                                                  .removeAt(index);
                                            });
                                            Navigator.of(context).pop();
                                            return true;
                                          },
                                        ),
                                      ],
                                    ),
                                  );

                                  // setState(() {
                                  //   Globals.client.removeFriend(
                                  //       Globals.client.getCachedFriends[index]);

                                  //   Globals.client.getCachedFriends
                                  //       .removeAt(index);
                                  // });
                                }

                                return false;
                              },
                              secondaryBackground: Container(
                                alignment: Alignment.centerRight,
                                color: Colors.green,
                                child: Icon(Icons.transfer_within_a_station),
                              ),
                              background: Container(
                                alignment: Alignment.centerLeft,
                                color: Colors.red,
                                child: Icon(Icons.delete_forever_outlined),
                              ),
                              key: ValueKey(
                                  Globals.client.getCachedFriends[index]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                  ),
                                  // CircleAvatar(
                                  //   radius: 20,
                                  //   backgroundImage:
                                  //       AssetImage('assets/images/avatar.png'),
                                  // ),
                                  // RichText(
                                  //     text: TextSpan(
                                  //   style: Theme.of(context).textTheme.headline2,
                                  //   text:
                                  //       "${Globals.client.getCachedFriends[index]}\n",
                                  //   children: <TextSpan>[
                                  //     TextSpan(
                                  //         text:
                                  //             "${Globals.client.getCachedFriends[index]}@email.com",
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .subtitle1),
                                  //   ],
                                  // )),

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
                              )));
                    },
                    childCount: Globals.client.getCachedFriends.length,
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

// class MyForm extends StatefulWidget {
//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {

//   @override
//   Widget build(BuildContext context) {

//     return ;
//   }
// }
