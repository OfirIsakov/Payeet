import 'package:flutter/material.dart';
import 'package:Payeet/globals.dart';

class FollowersPage extends StatefulWidget {
  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).highlightColor),
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),
      body: Column(
        children: [
          LimitedBox(
            maxHeight: 400,
            child: ListView.builder(
                itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      dense: false,
                      enabled: true,
                      title: Text(
                        "${Globals.client.getCachedFollowers[index].mail}\n",
                        style:
                            TextStyle(color: Theme.of(context).highlightColor),
                      ),
                      trailing: TextButton(
                          onPressed: () async {
                            try {
                              await Globals.client.addFriend(
                                  Globals.client.getCachedFollowers[index].mail);
                              setState(() {
                                Globals.client.getCachedFriends.add(
                                    Globals.client.getCachedFollowers[index]);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Added successfully'),
                                backgroundColor: Colors.green,
                              ));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('[${e.codeName}] ${e.message}'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          child: Text(
                            "Follow back",
                            style: TextStyle(
                                color: Theme.of(context).highlightColor),
                          )),
                    ),
                itemCount: Globals.client.getCachedFollowers.length),
          )
        ],
      ),
    );
  }
}
