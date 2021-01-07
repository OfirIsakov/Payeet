import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart' as $grpc;

import 'dart:async';


// implementing the ClientChannel to have an interceptor to set the authorization
// metadata header when each request is invoked
class PayeetChannel implements $grpc.ClientChannel {
  final $grpc.ClientChannel channel;
  CallOptions options;

  PayeetChannel(this.channel);

  @override
  Future<void> shutdown() => channel.shutdown();

  @override
  Future<void> terminate() => channel.terminate();

  @override
  ClientCall<Q, R> createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options) {
    return channel.createCall<Q, R>(method, requests, options.mergedWith(this.options));        
  }

  void addAccessTokenMetadata(String accessToken) {
    options = CallOptions(metadata: {'authorization': accessToken}).mergedWith(options);
  }
}
