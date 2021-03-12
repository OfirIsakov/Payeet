import 'dart:io';

import 'package:Payeet/Screens/VerifyPage.dart';
import 'package:fixnum/fixnum.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart' as $grpc;

import 'dart:async';

import 'protos/payeet.pb.dart';
import 'protos/payeet.pbgrpc.dart';

import '../secure_storage.dart';

class PayeetClient {
  final SecureStorage secureStorage = SecureStorage();
  final PayeetChannel channel;

  String _accessToken;
  Int64 tokenExpiresOn;
  String _refreshToken;

  payeet_authClient _unauthenticatedClient;
  payeetClient _authenticatedClient;

  bool
      _cachedBalance; // this is true when the client class has cached the user's balance
  String _balance;

  bool
      _cachedInfo; // this is true when the client class has cached the user info from the server
  String _firstName;
  String _lastName;
  List<GenericUser> _friends;
  List<GenericUser> _followers;

  List<UserInfoResponse> _topUsers;
  List<String> _profileImages;

  String _mail;
  int _imageID;

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
  List<GenericUser> get getCachedFriends => _friends;
  List<GenericUser> get getCachedFollowers => _followers;
  List<String> get getCachedProfileImages => _profileImages;
  List<UserInfoResponse> get getTopUsers => _topUsers;
  String get getCachedMail => _mail;
  int get getCachedImageID => _imageID;

   Future<LoginResponse> login(String mail, String password) async {
    LoginResponse response;

    String identifier = '';
    String deviceName = '';
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var data = await deviceInfoPlugin.androidInfo;
        identifier = data.androidId; // ID for Android
        deviceName = data.brand + ' ' + data.model; // brand and model. eg: "Xiaomi MI 8"
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; // ID for iOS
        deviceName = data.utsname.machine; // model. eg: "iphone 7"
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    try {
      response = await _unauthenticatedClient.login(LoginRequest()
        ..mail = mail
        ..password = password
        ..identifier = identifier
        ..deviceName = deviceName);
    } catch (e) {
      rethrow; // cant login so throw the error
    }


    _accessToken = response.accessToken;
    tokenExpiresOn = response.expiresOn;
    _refreshToken = response.refreshToken;

    await SecureStorage.writeSecureData('refreshToken', _refreshToken);

    channel.setAccessTokenMetadata(_accessToken);
    _authenticatedClient =
        payeetClient(channel); // create the authenticated client

    await getUserInfo();

    return response;
  }

  Future<bool> loginWithRefresh() async {
    _refreshToken = await SecureStorage.readSecureData('refreshToken');
    LoginResponse response;

    try {
      response = await _unauthenticatedClient
          .refreshToken(RefreshTokenRequest()..refreshToken = _refreshToken);
    } catch (e) {
      //rethrow; // cant login so throw the error
      return false;
    }

    _accessToken = response.accessToken;
    tokenExpiresOn = response.expiresOn;
    _refreshToken = response.refreshToken;

    await SecureStorage.writeSecureData('refreshToken', _refreshToken);

    channel.setAccessTokenMetadata(_accessToken);
    _authenticatedClient =
        payeetClient(channel); // create the authenticated client

    await getUserInfo();

    return true;
  }

  Future<StatusResponse> register(
      String firstName, String lastName, String mail, String password) async {
    final response = await _unauthenticatedClient.register(RegisterRequest()
          ..firstName = firstName
          ..lastName = lastName
          ..mail = mail
          ..password =
              password // add a small hash logic as sending a plain text password isnt a good practice
        );

    return response;
  }

  // resendCode asks the server to send the given mail a new otp code
  // getVerifyCode may fail and return Unavailable because the user is on timeout.
  Future<StatusResponse> resendCode(String mail) async {
    final response =
        await _unauthenticatedClient.getVerifyCode(CodeRequest()..mail = mail);
    return response;
  }

  ResponseStream<HistoryResponse> getTransferHistory(String mail) {
    final response = _authenticatedClient
        .getFullHistory(HistoryRequest()..senderMail = mail);

    return response;
  }

  ResponseStream<GenericUser> searchFriend(String text) {
    final response =
        _authenticatedClient.searchFriend(SearchFriendRequest()..search = text);

    return response;
  }

  Future<LoginResponse> refreshAccessToken() async {
    final response = await _unauthenticatedClient
        .refreshToken(RefreshTokenRequest()..refreshToken = _refreshToken);

    _accessToken = response.accessToken;
    tokenExpiresOn = response.expiresOn;
    _refreshToken = response.refreshToken;
    channel.setAccessTokenMetadata(_accessToken);

    return response;
  }

  Future<BalanceResponse> getBalance() async {
    final response = await _authenticatedClient.getBalance(BalanceRequest());

    _cachedBalance = true;
    _balance = response.balance;

    return response;
  }

  Future<UserInfoResponse> getUserInfo() async {
    final response = await _authenticatedClient.getUserInfo(UserInfoRequest());

    // caching the user info
    _firstName = response.firstName;
    _lastName = response.lastName;
    _mail = response.mail;
    _imageID = response.imageID.toInt();

    return response;
  }

  Future<StatusResponse> transferBalance(String mail, int amount) async {
    final response =
        await _authenticatedClient.transferBalance(TransferRequest()
          ..receiverMail = mail
          ..amount = amount);

    return response;
  }

  Future<StatusResponse> addFriend(String mail) async {
    final response =
        await _authenticatedClient.addFriend(AddFriendRequest()..mail = mail);

    return response;
  }

  Future<StatusResponse> verify(String code, String mail) async {
    final response = await _unauthenticatedClient.verify(VerifyRequest()
      ..code = code
      ..mail = mail);

    return response;
  }

  Future<StatusResponse> removeFriend(String mail) async {
    final response = await _authenticatedClient
        .removeFriend(RemoveFriendRequest()..mail = mail);

    return response;
  }

  Future<void> getFriends() async {
    _friends =
        await _authenticatedClient.getFriends(GetFriendsRequest()).toList();
  }

  Future<void> fetchFollowers() async {
    _followers =
        await _authenticatedClient.getFollowers(GetFollowersRequest()).toList();
  }

  Future<void> fetchTopUsers() async {
    final response = await _authenticatedClient.getTopUsers(TopUsersRequest());

    this._topUsers = response.users;
  }

  Future<void> fetchProfileImages() async {
    final response =
        await _authenticatedClient.getProfileImages(ImagesRequest());
    this._profileImages = response.images;
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
    return channel.createCall<Q, R>(
        method, requests, options.mergedWith(_options));
  }

  void setAccessTokenMetadata(String accessToken) {
    _options = CallOptions(metadata: {'authorization': accessToken});
  }
}
