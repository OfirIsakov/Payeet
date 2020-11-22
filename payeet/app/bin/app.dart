import 'package:grpc/grpc.dart';

import 'package:payeet/protos/dart/payeet.pb.dart';
import 'package:tutorial/protos/dart/payeet.pbgrpc.dart';


Future<void> main(List<String> args) async {
  final channel = ClientChannel(
    'localhost',
    port: 6969,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
  
  final stub = payeetClient(channel);

  try {
    
    final response = await stub.login(
      LoginRequest()
      ..a = "mail"
      ..b = "password"

      );

    print('Client received: ${response.result}');
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}
