import 'package:fixnum/fixnum.dart';

import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart' as $grpc;

import 'dart:async';

import 'protos/payeet.pb.dart';
import 'protos/payeet.pbgrpc.dart';


class PayeetClient {
  final PayeetChannel channel;

  String _accessToken;
  Int64 tokenExpiresOn;
  String _refreshToken;

  payeet_authClient _unauthenticatedClient;
  payeetClient _authenticatedClient;
  
  bool _cachedBalance; // this is true when the client class has cached the user's balance
  String _balance;

  bool _cachedInfo; // this is true when the client class has cached the user info from the server
  String _firstName;
  String _lastName;
  String _userID;
  
  // ctor
  PayeetClient(this.channel) {
    _cachedInfo = false;
    _unauthenticatedClient = payeet_authClient(channel);
  } 

  bool get cachedBalance => _cachedBalance;
  String get getCachedBalance => _balance;

  bool get cachedInfo => _cachedInfo;
  String get getCachedFirstName => _firstName;
  String get getCachedLastName => _lastName;
  String get getCachedUserID => _userID;

  Future<LoginResponse> login(String mail, String password) async {
    LoginResponse response;
    try {
      response = await _unauthenticatedClient.login(
        LoginRequest()
        ..mail = mail
        ..password = password
      );
    } catch (e) {
      rethrow; // cant login so throw the error
    }

    _accessToken = response.accessToken;
    tokenExpiresOn = response.expiresOn;
    _refreshToken = response.refreshToken;
    
    channel.setAccessTokenMetadata(_accessToken);
    _authenticatedClient = payeetClient(channel); // create the authenticated client

    return response;
  }

  Future<StatusResponse> register(String firstName, String lastName, String mail, String password) async {
    final response = await _unauthenticatedClient.register(
      RegisterRequest()
      ..firstName = firstName
      ..lastName = lastName
      ..mail = mail
      ..password = password // add a small hash logic as sending a plain text password isnt a good practice
    );

    return response;
  }

  Future<LoginResponse> getTransferHistory() async {
    //TODO
    //NOTE: this should be a stream

    return null;
  }

  Future<LoginResponse> refreshAccessToken() async {
    final response = await _unauthenticatedClient.refreshToken(
      RefreshTokenRequest()
      ..refreshToken = _refreshToken
    );

    _accessToken = response.accessToken;
    tokenExpiresOn = response.expiresOn;
    _refreshToken = response.refreshToken;

    return response;
  }
  
  Future<BalanceResponse> getBalance() async {
    final response = await _authenticatedClient.getBalance(
      BalanceRequest()
    );
    
    _cachedBalance = true;
    _balance = response.balance;

    return response;
  }
  
  Future<UserInfoResponse> getUserInfo() async {
    final response = await _authenticatedClient.getUserInfo(
      UserInfoRequest()
    );
    
    // caching the user info
    _firstName = response.firstName;
    _lastName = response.lastName;
    _userID = response.userID;

    return response;
  }

  Future<StatusResponse> transferBalance(String mail, int amount) async {
    final response = await _authenticatedClient.transferBalance(
      TransferRequest()
      ..receiverMail = mail
      ..amount = amount
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
