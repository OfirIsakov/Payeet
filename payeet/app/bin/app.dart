import 'package:grpc/grpc.dart';

import '../../protos/dart/payeet.pb.dart';
import '../../protos/dart/payeet.pbgrpc.dart';
import 'payeetChannel.dart';

//TODO: Implement a client class to save the refreshToken and do the client logic

Future<void> main(List<String> args) async {
  
  final channel = PayeetChannel(
    ClientChannel(
    'localhost',
    port: 6969,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    ),
  );
  
  final authStub = payeet_authClient(channel);

  try {
    print('---------------------------------------------------------------');

    print('sendRegisterRequest...');
    print('Register response recieved:\n${await sendRegisterRequest(authStub)}');

    print('---------------------------------------------------------------');

    // when logging in we get the access token and we need to send it with every request
    print('sendLoginRequest...');
    var user = await sendLoginRequest(authStub); 
    print('Login response recieved:\n${user}');

    // once we get the token we can attach it to the payeetChannel type we implemented
    channel.addAccessTokenMetadata(user.accessToken);

    print('---------------------------------------------------------------');

    print('sendRefreshRequest...');
    user = await sendRefreshRequest(authStub, user.refreshToken);
    print('RefreshToken response recieved:\n${user}');

    print('---------------------------------------------------------------');
    final normalStub = payeetClient(channel);
    

    print('sendBalanceRequest...');
    print('Balance response recieved:\n${await sendBalanceRequest(normalStub)}');

    print('---------------------------------------------------------------');

    print('sendUserInfoRequest...');
    print('UserInfo response recieved:\n${await sendUserInfoRequest(normalStub)}');

    print('---------------------------------------------------------------');

    print('sendTransferRequest...');
    print('Transfer response recieved:\n${await sendTransferRequest(normalStub)}');

    print('---------------------------------------------------------------');
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}

Future<LoginResponse> sendLoginRequest(payeet_authClient stub) async {
    final response = await stub.login(
      LoginRequest()
      ..mail = 'israel@israeli.co.il'
      ..password = '2hard2guess'
      );

    return response;
}

Future<StatusResponse> sendRegisterRequest(payeet_authClient stub) async {
    final response = await stub.register(
      RegisterRequest()
      ..firstName = 'israel'
      ..lastName = 'israeli'
      ..mail = 'israel@israeli.co.il'
      ..password = '2hard2guess'
      );

    return response;
}

Future<LoginResponse> sendRefreshRequest(payeet_authClient stub, String refreshToken) async {
    final response = await stub.refreshToken(
      RefreshTokenRequest()
      ..refreshToken = refreshToken
      );

    return response;
}

Future<BalanceResponse> sendBalanceRequest(payeetClient stub) async {
    final response = await stub.getBalance(
      BalanceRequest()
      );

    return response;
}

Future<UserInfoResponse> sendUserInfoRequest(payeetClient stub) async {
    final response = await stub.getUserInfo(
      UserInfoRequest()
      );

    return response;
}

Future<StatusResponse> sendTransferRequest(payeetClient stub) async {
    final response = await stub.transferBalance(
      TransferRequest()
      );

    return response;
}
