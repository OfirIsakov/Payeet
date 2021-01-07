import 'dart:ffi';

import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart' as $grpc;

import 'dart:async';

import '../../protos/dart/payeet.pb.dart';
import '../../protos/dart/payeet.pbgrpc.dart';


class PayeetClient {
  final PayeetChannel channel;

  String _accessToken;
  String refreshToken;

  payeet_authClient _unauthenticatedClient;
  payeetClient _authenticatedClient;

  PayeetClient(this.channel); // ctor

  set accessToken(String token){
    _accessToken = token;
    channel.setAccessTokenMetadata(_accessToken);
  }

  payeet_authClient get unauthenticatedClient => _unauthenticatedClient;

  payeetClient get authenticatedClient => _authenticatedClient;

  void createUnauthenticatedClient(){
    _unauthenticatedClient = payeet_authClient(channel);
  }

  void createAuthenticatedClient(){
    // only create the channel is theres an auth token
    if (_accessToken == '') {
      return;
    }
    _authenticatedClient = payeetClient(channel);
  }

  Future<LoginResponse> login() async {
      final response = await _unauthenticatedClient.login(
        LoginRequest()
        ..mail = 'israel@israeli.co.il'
        ..password = '2hard2guess'
        );

      return response;
  }

  Future<StatusResponse> register() async {
      final response = await _unauthenticatedClient.register(
        RegisterRequest()
        ..firstName = 'israel'
        ..lastName = 'israeli'
        ..mail = 'israel@israeli.co.il'
        ..password = '2hard2guess'
        );

      return response;
  }

  Future<LoginResponse> refreshAccessToken() async {
      final response = await unauthenticatedClient.refreshToken(
        RefreshTokenRequest()
        ..refreshToken = refreshToken
        );

      return response;
  }
  
  Future<BalanceResponse> getBalance() async {
      final response = await authenticatedClient.getBalance(
        BalanceRequest()
        );

      return response;
  }
  
  Future<UserInfoResponse> getUserInfo() async {
      final response = await authenticatedClient.getUserInfo(
        UserInfoRequest()
        );

      return response;
  }

  Future<StatusResponse> transferBalance(String mail, double amount) async {
      final response = await authenticatedClient.transferBalance(
        TransferRequest()
        );

      return response;
  }
}


// implementing the ClientChannel to have an interceptor to set the authorization
// metadata header when each request is invoked
class PayeetChannel implements $grpc.ClientChannel {
  final $grpc.ClientChannel channel;
  CallOptions _options;

  PayeetChannel(this.channel); // ctor

  @override
  Future<void> shutdown() => channel.shutdown();

  @override
  Future<void> terminate() => channel.terminate();

  @override
  ClientCall<Q, R> createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options) {
    return channel.createCall<Q, R>(method, requests, options.mergedWith(_options));        
  }

  void setAccessTokenMetadata(String accessToken) {
    _options = CallOptions(metadata: {'authorization': accessToken}).mergedWith(_options);
  }
}
