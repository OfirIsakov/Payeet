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
  
  client.createUnauthenticatedClient();

  try {
    print('---------------------------------------------------------------');

    print('sendRegisterRequest...');
    print('Register response recieved:\n${await client.register('isarel', 'israeli', 'israel@israeli.co.il', '2hard2guess')}');

    print('---------------------------------------------------------------');

    print('sendLoginRequest(Incorrect)...');
    try {
      print('Login response recieved:\n${await client.login('incorrect@user.wrong', '213374u')}');
    } catch (e) {
      print(e);
    }

    print('---------------------------------------------------------------');

    // when logging in we get the auth tokens and we need to send the access token with every request
    print('sendLoginRequest(Correct)...');
    var user = await client.login('israel@israeli.co.il', '2hard2guess'); 
    print('Login response recieved:\n${user}');

    // once we get the tokens we can attach it to the payeetClient's channel we implemented
    client.accessToken = user.accessToken;
    client.refreshToken = user.refreshToken;
    client.createAuthenticatedClient(); // create the authenticated channel

    print('---------------------------------------------------------------');

    print('sendRefreshRequest...');
    user = await client.refreshAccessToken();
    print('RefreshToken response recieved:\n${user}');

    print('---------------------------------------------------------------');
    

    print('sendBalanceRequest...');
    print('Balance response recieved:\n${await client.getBalance()}');

    print('---------------------------------------------------------------');

    print('sendUserInfoRequest...');
    print('UserInfo response recieved:\n${await client.getUserInfo()}');

    print('---------------------------------------------------------------');

    print('sendTransferRequest...');
    print('Transfer response recieved:\n${await client.transferBalance('To@who.com', 1337.69)}');

    print('---------------------------------------------------------------');
  } catch (e) {
    print('Caught error: $e');
  }
  await client.channel.shutdown();
}
