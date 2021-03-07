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
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "TopUsers",
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
                              Globals.client.getTopUsers[1].mail,
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
                            Globals.client.getTopUsers[0].mail,
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
                            Globals.client.getTopUsers[2].mail,
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
                "Friends activity",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            LimitedBox(
              maxHeight: 200,
              child: ListView.separated(
                itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ListTile(
                      onTap: () async {
                        setState(() {
                          context.read(Globals.transfer_email).state =
                              Globals.client.getCachedFriends[index];
                          selected_index = index;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Scaffold(
                                        appBar: AppBar(
                                          iconTheme: IconThemeData(
                                              color: Theme.of(context)
                                                  .highlightColor),
                                          backgroundColor: Theme.of(context)
                                              .bottomAppBarColor,
                                          title: Text(Globals
                                              .client.getCachedFriends[index], style: TextStyle(color: Theme.of(context).highlightColor),),
                                        ),
                                        backgroundColor:
                                            Theme.of(context).backgroundColor,
                                        body: StatsPage(
                                          transferEmail: Globals
                                              .client.getCachedFriends[index],
                                        ),
                                      )));
                        });
                      },
                      selected: selected_index == index,
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      dense: false,
                      enabled: true,
                      title: Text(
                        "${Globals.client.getCachedFriends[index]}\n",
                        // style:
                        // TextStyle(color: Theme.of(context).highlightColor),
                      ),
                      subtitle: Text(
                        "${Globals.client.getCachedFriends[index]}",
                        style:
                            TextStyle(color: Theme.of(context).highlightColor),
                      ),
                      trailing: Icon(
                        Icons.transfer_within_a_station,
                        color: Theme.of(context).highlightColor,
                      ),
                    )),
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
