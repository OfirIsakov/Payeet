import 'package:grpc/grpc.dart';

import '../../protos/dart/payeet.pb.dart';
import '../../protos/dart/payeet.pbgrpc.dart';


Future<void> main(List<String> args) async {
  final channel = ClientChannel(
    'localhost',
    port: 6969,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
  
  final authStub = payeet_authClient(channel);

  try {
    print('---------------------------------------------------------------');

    print('sendRegisterRequest...');
    print('Register response recieved:\n${await sendRegisterRequest(authStub)}');

    print('---------------------------------------------------------------');

    print('sendLoginRequest...');
    var user = await sendLoginRequest(authStub);
    print('Login response recieved:\n${user}');

    print('---------------------------------------------------------------');

    print('sendRefreshRequest...');
    user = await sendRefreshRequest(authStub, user.refreshToken);
    print('RefreshToken response recieved:\n${user}');

    print('---------------------------------------------------------------');

    final jwt = <String, String>{};
    jwt['authorization'] = user.accessToken;
    final normalStub = payeetClient(channel, options: CallOptions(metadata: jwt));

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
