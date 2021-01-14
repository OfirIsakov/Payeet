import 'package:grpc/grpc.dart';

import 'payeetClient.dart';

Future<void> main(List<String> args) async {
  var client = PayeetClient(
    PayeetChannel(
      ClientChannel(
        'localhost',
        port: 6969,
        options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
      ),
    )
  );

  try {
    print('---------------------------------------------------------------');

    print('sendRegisterRequest...');

    try {
      print('registering israel@israeli.co.il');
      print(
          'Register response recieved:\n${await client.register('isarel', 'israeli', 'israel@israeli.co.il', '2hard2guess')}');
    }
     catch (e) {
      print(e);
    }

    print('---------------------------------------------------------------');
    
    try {
      print('registering To@who.com');
      print(
          'Register response recieved:\n${await client.register('dr', 'who', 'To@who.com', '2hard2guess')}');
    }
     catch (e) {
      print(e);
    }

    print('---------------------------------------------------------------');

    print('sendLoginRequest(Incorrect)...');
    try {
      print('Login response recieved:\n${await client.login('incorrect@user.wrong', '213374u')}');
    } catch (e) {
      print(e);
      e.toString();
    }

    print('---------------------------------------------------------------');

    // when logging in we get the auth tokens and we need to send the access token with every request
    print('sendLoginRequest(Correct)...');
    try {
      print('Login response recieved:\n${await client.login('israel@israeli.co.il', '2hard2guess')}');
    } catch (e) {
      print(e);
      e.toString();
    }

    // once we get the tokens we can attach it to the payeetClient's channel we implemented

    print('---------------------------------------------------------------');

    print('sendRefreshRequest...');
    print('RefreshToken response recieved:\n${await client.refreshAccessToken()}');

    print('---------------------------------------------------------------');
    

    print('sendBalanceRequest...');
    print('Balance response recieved:\n${await client.getBalance()}');

    print('---------------------------------------------------------------');

    print('sendUserInfoRequest...');
    print('UserInfo response recieved:\n${await client.getUserInfo()}');

    print('---------------------------------------------------------------');

    print('sendTransferRequest...');
    print('Transfer response recieved:\n${await client.transferBalance('To@who.com', 1337)}');

    print('---------------------------------------------------------------');
  } catch (e) {
    print('Caught error: $e');
  }
  await client.channel.shutdown();
}
