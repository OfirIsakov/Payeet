import 'package:Payeet/UI_Elements/confirm.dart';
import 'package:Payeet/grpc/protos/payeet.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Payeet/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'StatsPage.dart';

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
  int selected_index = 0;

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
              padding: const EdgeInsets.only(bottom: 40),
              child: Text(
                "Top Users",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            FractionallySizedBox(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          child: Image(
                              image: AssetImage('assets/images/cup2.png')),
                          height: 60,
                          width: 70,
                        ),
                        FittedBox(
                          child: Container(
                            child: Text(
                              Globals.client.getTopUsers[1].mail.length > 0
                                  ? Globals.client.getTopUsers[1].mail
                                  : " ", // need a space so the layout wont break, flutter limitations
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).highlightColor),
                            ),
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Image(
                              image: AssetImage('assets/images/cup1.png')),
                          height: 80,
                          width: 90,
                        ),
                        FittedBox(
                          child: Container(
                              child: Text(
                            Globals.client.getTopUsers[0].mail.length > 0
                                ? Globals.client.getTopUsers[0].mail
                                : " ", // need a space so the layout wont break, flutter limitations
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).highlightColor),
                          )),
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          child: Container(),
                          height: 30,
                          width: 20,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          child: Container(),
                          height: 30,
                          width: 20,
                        ),
                        SizedBox(
                          child: Image(
                              image: AssetImage('assets/images/cup3.png')),
                          height: 60,
                          width: 70,
                        ),
                        FittedBox(
                          child: Container(
                              child: Text(
                            Globals.client.getTopUsers[2].mail.length > 0
                                ? Globals.client.getTopUsers[2].mail
                                : " ", // need a space so the layout wont break, flutter limitations
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).highlightColor),
                          )),
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "Friends",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            LimitedBox(
              maxHeight: 200,
              child: ListView.separated(
                itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).bottomAppBarColor),
                        child: Dismissible(
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                context.read(Globals.selectedIndex).state = 2;
                                setState(() {
                                  context.read(Globals.transfer_email).state =
                                      Globals
                                          .client.getCachedFriends[index].mail;
                                  selected_index = index;
                                });
                              }

                              // remove friend.
                              if (direction == DismissDirection.startToEnd) {
                                showDialog(
                                  context: context,
                                  builder: (_) => ConfirmDialog(
                                    danger: true,
                                    title: 'Unfollow',
                                    content: Text(
                                        'Would you like to remove ${Globals.client.getCachedFriends[index].mail} from your favorites?',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18)),
                                    cancelFunction: () {
                                      setState(() {
                                        Globals.client.getCachedFriends;
                                      });
                                      Navigator.of(context).pop();
                                      return false;
                                    },
                                    actionText: Text('Approve'),
                                    actionFunction: () async {
                                      try {
                                        await Globals.client.removeFriend(
                                            Globals.client
                                                .getCachedFriends[index].mail);
                                        setState(() {
                                          Globals.client.getCachedFriends
                                              .removeAt(index);
                                        });
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
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
                                );
                              }

                              return false;
                            },
                            secondaryBackground: Container(
                              decoration: BoxDecoration(color: Colors.green),
                              alignment: Alignment.centerRight,
                              child: Icon(CupertinoIcons.money_dollar_circle),
                            ),
                            background: Container(
                              decoration: BoxDecoration(color: Colors.red),
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.delete_forever_outlined),
                            ),
                            key: ValueKey(
                                Globals.client.getCachedFriends[index]),
                            child: ListTile(
                              onTap: () async {
                                setState(() {
                                  context.read(Globals.transfer_email).state =
                                      Globals
                                          .client.getCachedFriends[index].mail;
                                  selected_index = index;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Scaffold(
                                                appBar: AppBar(
                                                  iconTheme: IconThemeData(
                                                      color: Theme.of(context)
                                                          .highlightColor),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .accentColor,
                                                  title: Text(
                                                    Globals
                                                        .client
                                                        .getCachedFriends[index]
                                                        .mail,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .highlightColor),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .backgroundColor,
                                                body: StatsPage(
                                                  transferEmail: Globals
                                                      .client
                                                      .getCachedFriends[index]
                                                      .mail,
                                                ),
                                              )));
                                });
                              },
                              selected: selected_index == index,
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    Globals.client.getCachedProfileImages[
                                        Globals.client.getCachedFriends[index]
                                            .imageID
                                            .toInt()]),
                              ),
                              dense: false,
                              enabled: true,
                              title: Text(
                                "${Globals.client.getCachedFriends[index].mail}\n",
                              ),
                              trailing:
                                  Icon(CupertinoIcons.arrow_right_arrow_left),
                            )))),
                separatorBuilder: (_, index) => SizedBox(
                  height: 10,
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
