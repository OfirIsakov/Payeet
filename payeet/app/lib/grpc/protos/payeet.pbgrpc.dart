///
//  Generated code. Do not modify.
//  source: payeet.proto
//
// @dart = 2.12
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
  static final _$verify =
      $grpc.ClientMethod<$0.VerifyRequest, $0.StatusResponse>(
          '/payeet.payeet_auth/Verify',
          ($0.VerifyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.StatusResponse.fromBuffer(value));
  static final _$getVerifyCode =
      $grpc.ClientMethod<$0.CodeRequest, $0.StatusResponse>(
          '/payeet.payeet_auth/GetVerifyCode',
          ($0.CodeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.StatusResponse.fromBuffer(value));

  payeet_authClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.LoginResponse> login($0.LoginRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.LoginResponse> refreshToken(
      $0.RefreshTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refreshToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> register($0.RegisterRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> verify($0.VerifyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verify, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> getVerifyCode($0.CodeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVerifyCode, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$0.VerifyRequest, $0.StatusResponse>(
        'Verify',
        verify_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyRequest.fromBuffer(value),
        ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CodeRequest, $0.StatusResponse>(
        'GetVerifyCode',
        getVerifyCode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CodeRequest.fromBuffer(value),
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

  $async.Future<$0.StatusResponse> verify_Pre(
      $grpc.ServiceCall call, $async.Future<$0.VerifyRequest> request) async {
    return verify(call, await request);
  }

  $async.Future<$0.StatusResponse> getVerifyCode_Pre(
      $grpc.ServiceCall call, $async.Future<$0.CodeRequest> request) async {
    return getVerifyCode(call, await request);
  }

  $async.Future<$0.LoginResponse> login(
      $grpc.ServiceCall call, $0.LoginRequest request);
  $async.Future<$0.LoginResponse> refreshToken(
      $grpc.ServiceCall call, $0.RefreshTokenRequest request);
  $async.Future<$0.StatusResponse> register(
      $grpc.ServiceCall call, $0.RegisterRequest request);
  $async.Future<$0.StatusResponse> verify(
      $grpc.ServiceCall call, $0.VerifyRequest request);
  $async.Future<$0.StatusResponse> getVerifyCode(
      $grpc.ServiceCall call, $0.CodeRequest request);
}

class payeetClient extends $grpc.Client {
  static final _$getProfileImages =
      $grpc.ClientMethod<$0.ImagesRequest, $0.ImagesResponse>(
          '/payeet.payeet/GetProfileImages',
          ($0.ImagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.ImagesResponse.fromBuffer(value));
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
  static final _$getFollowers =
      $grpc.ClientMethod<$0.GetFollowersRequest, $0.GetFollowersResponse>(
          '/payeet.payeet/GetFollowers',
          ($0.GetFollowersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetFollowersResponse.fromBuffer(value));
  static final _$getFriends =
      $grpc.ClientMethod<$0.GetFriendsRequest, $0.GetFriendsResponse>(
          '/payeet.payeet/GetFriends',
          ($0.GetFriendsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetFriendsResponse.fromBuffer(value));
  static final _$searchFriend =
      $grpc.ClientMethod<$0.SearchFriendRequest, $0.SearchFriendResponse>(
          '/payeet.payeet/SearchFriend',
          ($0.SearchFriendRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SearchFriendResponse.fromBuffer(value));
  static final _$getFullHistory =
      $grpc.ClientMethod<$0.HistoryRequest, $0.HistoryResponse>(
          '/payeet.payeet/GetFullHistory',
          ($0.HistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.HistoryResponse.fromBuffer(value));
  static final _$getTopUsers =
      $grpc.ClientMethod<$0.TopUsersRequest, $0.TopUsersResponse>(
          '/payeet.payeet/GetTopUsers',
          ($0.TopUsersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.TopUsersResponse.fromBuffer(value));
  static final _$getFiveFriendsTransfers =
      $grpc.ClientMethod<$0.FiveFriendsHistoryRequest, $0.HistoryResponse>(
          '/payeet.payeet/GetFiveFriendsTransfers',
          ($0.FiveFriendsHistoryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.HistoryResponse.fromBuffer(value));

  payeetClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.ImagesResponse> getProfileImages(
      $0.ImagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getProfileImages, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserInfoResponse> getUserInfo(
      $0.UserInfoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.BalanceResponse> getBalance($0.BalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> transferBalance(
      $0.TransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> addFriend($0.AddFriendRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addFriend, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> removeFriend(
      $0.RemoveFriendRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeFriend, request, options: options);
  }

  $grpc.ResponseStream<$0.GetFollowersResponse> getFollowers(
      $0.GetFollowersRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getFollowers, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.GetFriendsResponse> getFriends(
      $0.GetFriendsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getFriends, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.SearchFriendResponse> searchFriend(
      $0.SearchFriendRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$searchFriend, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.HistoryResponse> getFullHistory(
      $0.HistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getFullHistory, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.TopUsersResponse> getTopUsers(
      $0.TopUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTopUsers, request, options: options);
  }

  $grpc.ResponseStream<$0.HistoryResponse> getFiveFriendsTransfers(
      $0.FiveFriendsHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getFiveFriendsTransfers, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class payeetServiceBase extends $grpc.Service {
  $core.String get $name => 'payeet.payeet';

  payeetServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ImagesRequest, $0.ImagesResponse>(
        'GetProfileImages',
        getProfileImages_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ImagesRequest.fromBuffer(value),
        ($0.ImagesResponse value) => value.writeToBuffer()));
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
        $grpc.ServiceMethod<$0.GetFollowersRequest, $0.GetFollowersResponse>(
            'GetFollowers',
            getFollowers_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.GetFollowersRequest.fromBuffer(value),
            ($0.GetFollowersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFriendsRequest, $0.GetFriendsResponse>(
        'GetFriends',
        getFriends_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.GetFriendsRequest.fromBuffer(value),
        ($0.GetFriendsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SearchFriendRequest, $0.SearchFriendResponse>(
            'SearchFriend',
            searchFriend_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.SearchFriendRequest.fromBuffer(value),
            ($0.SearchFriendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HistoryRequest, $0.HistoryResponse>(
        'GetFullHistory',
        getFullHistory_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.HistoryRequest.fromBuffer(value),
        ($0.HistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TopUsersRequest, $0.TopUsersResponse>(
        'GetTopUsers',
        getTopUsers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TopUsersRequest.fromBuffer(value),
        ($0.TopUsersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.FiveFriendsHistoryRequest, $0.HistoryResponse>(
            'GetFiveFriendsTransfers',
            getFiveFriendsTransfers_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.FiveFriendsHistoryRequest.fromBuffer(value),
            ($0.HistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ImagesResponse> getProfileImages_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ImagesRequest> request) async {
    return getProfileImages(call, await request);
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

  $async.Stream<$0.GetFollowersResponse> getFollowers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetFollowersRequest> request) async* {
    yield* getFollowers(call, await request);
  }

  $async.Stream<$0.GetFriendsResponse> getFriends_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetFriendsRequest> request) async* {
    yield* getFriends(call, await request);
  }

  $async.Stream<$0.SearchFriendResponse> searchFriend_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SearchFriendRequest> request) async* {
    yield* searchFriend(call, await request);
  }

  $async.Stream<$0.HistoryResponse> getFullHistory_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HistoryRequest> request) async* {
    yield* getFullHistory(call, await request);
  }

  $async.Future<$0.TopUsersResponse> getTopUsers_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TopUsersRequest> request) async {
    return getTopUsers(call, await request);
  }

  $async.Stream<$0.HistoryResponse> getFiveFriendsTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.FiveFriendsHistoryRequest> request) async* {
    yield* getFiveFriendsTransfers(call, await request);
  }

  $async.Future<$0.ImagesResponse> getProfileImages(
      $grpc.ServiceCall call, $0.ImagesRequest request);
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
  $async.Stream<$0.GetFollowersResponse> getFollowers(
      $grpc.ServiceCall call, $0.GetFollowersRequest request);
  $async.Stream<$0.GetFriendsResponse> getFriends(
      $grpc.ServiceCall call, $0.GetFriendsRequest request);
  $async.Stream<$0.SearchFriendResponse> searchFriend(
      $grpc.ServiceCall call, $0.SearchFriendRequest request);
  $async.Stream<$0.HistoryResponse> getFullHistory(
      $grpc.ServiceCall call, $0.HistoryRequest request);
  $async.Future<$0.TopUsersResponse> getTopUsers(
      $grpc.ServiceCall call, $0.TopUsersRequest request);
  $async.Stream<$0.HistoryResponse> getFiveFriendsTransfers(
      $grpc.ServiceCall call, $0.FiveFriendsHistoryRequest request);
}
