///
//  Generated code. Do not modify.
//  source: payeet.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'payeet.pb.dart' as $0;
export 'payeet.pb.dart';

class payeet_authClient extends $grpc.Client {
  static final _$login = $grpc.ClientMethod<$0.LoginRequest, $0.LoginResponse>(
      '/payeet.payeet_auth/Login',
      ($0.LoginRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LoginResponse.fromBuffer(value));
  static final _$refreshToken =
      $grpc.ClientMethod<$0.RefreshTokenRequest, $0.LoginResponse>(
          '/payeet.payeet_auth/RefreshToken',
          ($0.RefreshTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.LoginResponse.fromBuffer(value));
  static final _$register =
      $grpc.ClientMethod<$0.RegisterRequest, $0.StatusResponse>(
          '/payeet.payeet_auth/Register',
          ($0.RegisterRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.StatusResponse.fromBuffer(value));

  payeet_authClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.LoginResponse> login($0.LoginRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.LoginResponse> refreshToken(
      $0.RefreshTokenRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$refreshToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> register($0.RegisterRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$register, request, options: options);
  }
}

abstract class payeet_authServiceBase extends $grpc.Service {
  $core.String get $name => 'payeet.payeet_auth';

  payeet_authServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.LoginRequest, $0.LoginResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LoginRequest.fromBuffer(value),
        ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RefreshTokenRequest, $0.LoginResponse>(
        'RefreshToken',
        refreshToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RefreshTokenRequest.fromBuffer(value),
        ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RegisterRequest, $0.StatusResponse>(
        'Register',
        register_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RegisterRequest.fromBuffer(value),
        ($0.StatusResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.LoginResponse> login_Pre(
      $grpc.ServiceCall call, $async.Future<$0.LoginRequest> request) async {
    return login(call, await request);
  }

  $async.Future<$0.LoginResponse> refreshToken_Pre($grpc.ServiceCall call,
      $async.Future<$0.RefreshTokenRequest> request) async {
    return refreshToken(call, await request);
  }

  $async.Future<$0.StatusResponse> register_Pre(
      $grpc.ServiceCall call, $async.Future<$0.RegisterRequest> request) async {
    return register(call, await request);
  }

  $async.Future<$0.LoginResponse> login(
      $grpc.ServiceCall call, $0.LoginRequest request);
  $async.Future<$0.LoginResponse> refreshToken(
      $grpc.ServiceCall call, $0.RefreshTokenRequest request);
  $async.Future<$0.StatusResponse> register(
      $grpc.ServiceCall call, $0.RegisterRequest request);
}

class payeetClient extends $grpc.Client {
  static final _$getUserInfo =
      $grpc.ClientMethod<$0.UserInfoRequest, $0.UserInfoResponse>(
          '/payeet.payeet/GetUserInfo',
          ($0.UserInfoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UserInfoResponse.fromBuffer(value));
  static final _$getBalance =
      $grpc.ClientMethod<$0.BalanceRequest, $0.BalanceResponse>(
          '/payeet.payeet/GetBalance',
          ($0.BalanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BalanceResponse.fromBuffer(value));
  static final _$transferBalance =
      $grpc.ClientMethod<$0.TransferRequest, $0.StatusResponse>(
          '/payeet.payeet/TransferBalance',
          ($0.TransferRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.StatusResponse.fromBuffer(value));
  static final _$addFriend =
      $grpc.ClientMethod<$0.AddFriendRequest, $0.StatusResponse>(
          '/payeet.payeet/AddFriend',
          ($0.AddFriendRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.StatusResponse.fromBuffer(value));
  static final _$removeFriend =
      $grpc.ClientMethod<$0.RemoveFriendRequest, $0.StatusResponse>(
          '/payeet.payeet/RemoveFriend',
          ($0.RemoveFriendRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.StatusResponse.fromBuffer(value));
  static final _$searchFriend =
      $grpc.ClientMethod<$0.SearchFriendRequest, $0.SearchFriendResponse>(
          '/payeet.payeet/SearchFriend',
          ($0.SearchFriendRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SearchFriendResponse.fromBuffer(value));

  payeetClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.UserInfoResponse> getUserInfo(
      $0.UserInfoRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getUserInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.BalanceResponse> getBalance($0.BalanceRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> transferBalance(
      $0.TransferRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$transferBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> addFriend($0.AddFriendRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$addFriend, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> removeFriend(
      $0.RemoveFriendRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$removeFriend, request, options: options);
  }

  $grpc.ResponseStream<$0.SearchFriendResponse> searchFriend(
      $0.SearchFriendRequest request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(
        _$searchFriend, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class payeetServiceBase extends $grpc.Service {
  $core.String get $name => 'payeet.payeet';

  payeetServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.UserInfoRequest, $0.UserInfoResponse>(
        'GetUserInfo',
        getUserInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UserInfoRequest.fromBuffer(value),
        ($0.UserInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BalanceRequest, $0.BalanceResponse>(
        'GetBalance',
        getBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.BalanceRequest.fromBuffer(value),
        ($0.BalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TransferRequest, $0.StatusResponse>(
        'TransferBalance',
        transferBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TransferRequest.fromBuffer(value),
        ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddFriendRequest, $0.StatusResponse>(
        'AddFriend',
        addFriend_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddFriendRequest.fromBuffer(value),
        ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RemoveFriendRequest, $0.StatusResponse>(
        'RemoveFriend',
        removeFriend_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RemoveFriendRequest.fromBuffer(value),
        ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SearchFriendRequest, $0.SearchFriendResponse>(
            'SearchFriend',
            searchFriend_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.SearchFriendRequest.fromBuffer(value),
            ($0.SearchFriendResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.UserInfoResponse> getUserInfo_Pre(
      $grpc.ServiceCall call, $async.Future<$0.UserInfoRequest> request) async {
    return getUserInfo(call, await request);
  }

  $async.Future<$0.BalanceResponse> getBalance_Pre(
      $grpc.ServiceCall call, $async.Future<$0.BalanceRequest> request) async {
    return getBalance(call, await request);
  }

  $async.Future<$0.StatusResponse> transferBalance_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TransferRequest> request) async {
    return transferBalance(call, await request);
  }

  $async.Future<$0.StatusResponse> addFriend_Pre($grpc.ServiceCall call,
      $async.Future<$0.AddFriendRequest> request) async {
    return addFriend(call, await request);
  }

  $async.Future<$0.StatusResponse> removeFriend_Pre($grpc.ServiceCall call,
      $async.Future<$0.RemoveFriendRequest> request) async {
    return removeFriend(call, await request);
  }

  $async.Stream<$0.SearchFriendResponse> searchFriend_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SearchFriendRequest> request) async* {
    yield* searchFriend(call, await request);
  }

  $async.Future<$0.UserInfoResponse> getUserInfo(
      $grpc.ServiceCall call, $0.UserInfoRequest request);
  $async.Future<$0.BalanceResponse> getBalance(
      $grpc.ServiceCall call, $0.BalanceRequest request);
  $async.Future<$0.StatusResponse> transferBalance(
      $grpc.ServiceCall call, $0.TransferRequest request);
  $async.Future<$0.StatusResponse> addFriend(
      $grpc.ServiceCall call, $0.AddFriendRequest request);
  $async.Future<$0.StatusResponse> removeFriend(
      $grpc.ServiceCall call, $0.RemoveFriendRequest request);
  $async.Stream<$0.SearchFriendResponse> searchFriend(
      $grpc.ServiceCall call, $0.SearchFriendRequest request);
}
