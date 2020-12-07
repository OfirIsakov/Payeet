import 'package:grpc/grpc.dart';

import '../../protos/dart/payeet.pb.dart';
import '../../protos/dart/payeet.pbgrpc.dart';


Future<void> main(List<String> args) async {
  final channel = ClientChannel(
    'localhost',
    port: 6969,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
  
  final stub = payeetClient(channel);

  try {
    print(await sendRegisterRequest(stub));
    print(await sendLoginRequest(stub));
    print(await sendGetBalanceRequest(stub));
    print(await sendTransferRequest(stub));
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}

Future<String> sendLoginRequest(payeetClient stub) async {
    print('Sending login request...');

    final response = await stub.login(
      LoginRequest()
      ..mail = 'mail'
      ..password = 'password'
      );

    return 'Login response recieved:\n${response}';
}

Future<String> sendRegisterRequest(payeetClient stub) async {
    print('Sending register request...');

    final response = await stub.register(
      RegisterRequest()
      ..firstName = 'israel'
      ..lastName = 'israeli'
      ..mail = 'mail'
      ..password = 'password'
      );

    return 'Register response recieved:\n${response}';
}

Future<String> sendGetBalanceRequest(payeetClient stub) async {
    print('Sending getBalance request...');

    final response = await stub.getBalance(
      BalanceRequest()
      ..userID = 'SuperCoolThigyMadeOutOfUUID'
      ..session = 'ThisIsARandomSetOfBytesOrIsThisThingDepricated?'
      );

    return 'GetBalance response recieved:\n${response}';
}

Future<String> sendTransferRequest(payeetClient stub) async {
    print('Sending sendTransfer request...');

    final response = await stub.transferBalance(
      TransferRequest()
      ..receiverMail = 'NotIsraelNotIsraeli@abroad.org'
      ..senderID = 'SuperCoolThigyMadeOutOfUUID'
      ..session = 'ThisIsARandomSetOfBytesOrIsThisThingDepricated?'
      );

    return 'SendTransfer response recieved:\n${response}';
}
