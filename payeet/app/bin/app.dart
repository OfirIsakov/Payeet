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
    
    final response = await stub.login(
      LoginRequest()
      ..mail = 'mail'
      ..password = 'password'

      );

    print('Client received: ${response}');
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}
