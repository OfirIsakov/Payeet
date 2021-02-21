import 'package:Payeet/grpc/protos/payeet.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Payeet/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "TopUsers",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            
            FractionallySizedBox(child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(child: Image(image: AssetImage('assets/images/cup2.png')),height: 60,width: 70,),
                      FittedBox(child: Container(child: Text(Globals.client.getTopUsers[1].userID, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).highlightColor),),),fit: BoxFit.fitWidth,),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(child: Image(image: AssetImage('assets/images/cup1.png')),height: 80,width: 90,),
                      FittedBox(child: Container(child: Text(Globals.client.getTopUsers[0].userID, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).highlightColor),)),fit: BoxFit.fitWidth,),
                      SizedBox(child: Container(),height: 30,width: 20,)
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(child: Container(),height: 30,width: 20,),
                      SizedBox(child: Image(image: AssetImage('assets/images/cup3.png')),height: 60,width: 70,),
                      FittedBox(child: Container(child: Text(Globals.client.getTopUsers[2].userID, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).highlightColor),)),fit: BoxFit.fitWidth,),
                    ],
                  )
                ],
              ),
            ),),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "Friends activity",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            
            LimitedBox(
              maxHeight: 200,
              child: ListView.separated(
                itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Dismissible(
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            print("transfer to friend.");
                            context.read(Globals.transfer_email).state =
                                Globals.client.getCachedFriends[index];
                            context.read(Globals.selectedIndex).state++;
                          }

                          // remove friend.
                          if (direction == DismissDirection.startToEnd) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                  'Delete ${Globals.client.getCachedFriends[index]}?',
                                  style: Theme.of(context).textTheme.bodyText1,
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
                                        await Globals.client.removeFriend(
                                            Globals.client
                                                .getCachedFriends[index]);
                                        setState(() {
                                          Globals.client.getCachedFriends
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
                        key: ValueKey(Globals.client.getCachedFriends[index]),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          ),
                          dense: false,
                          enabled: true,
                          title: Text(
                            "${Globals.client.getCachedFriends[index]}\n",
                            // style:
                            // TextStyle(color: Theme.of(context).highlightColor),
                          ),
                          subtitle: Text(
                              "${Globals.client.getCachedFriends[index]}",style:
                            TextStyle(color: Theme.of(context).highlightColor),),
                              
                        trailing: Icon(Icons.transfer_within_a_station, color: Theme.of(context).highlightColor,),
                        ))),
                separatorBuilder: (_, index) => SizedBox(
                  height: 30,
                ),
                itemCount: Globals.client.getCachedFriends.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
