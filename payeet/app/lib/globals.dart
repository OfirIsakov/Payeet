import 'package:Payeet/grpc/protos/payeet.pbgrpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Payeet/grpc/payeetClient.dart';
import 'package:grpc/grpc.dart';

class Globals {
  // this is the index of the current page.
  static var selectedIndex = StateProvider((ref) => 0);
  static var balance = StateProvider((ref) => 0);
  static var client = PayeetClient(PayeetChannel(
    ClientChannel(
      'localhost',
      port: 6969,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    ),
  ));
}