///
//  Generated code. Do not modify.
//  source: payeet.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class RegisterRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegisterRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FirstName', protoName: 'FirstName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastName', protoName: 'LastName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mail', protoName: 'Mail')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Password', protoName: 'Password')
    ..hasRequiredFields = false
  ;

  RegisterRequest._() : super();
  factory RegisterRequest() => create();
  factory RegisterRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterRequest clone() => RegisterRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterRequest copyWith(void Function(RegisterRequest) updates) => super.copyWith((message) => updates(message as RegisterRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterRequest create() => RegisterRequest._();
  RegisterRequest createEmptyInstance() => create();
  static $pb.PbList<RegisterRequest> createRepeated() => $pb.PbList<RegisterRequest>();
  @$core.pragma('dart2js:noInline')
  static RegisterRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterRequest>(create);
  static RegisterRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastName => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastName() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get mail => $_getSZ(2);
  @$pb.TagNumber(3)
  set mail($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMail() => $_has(2);
  @$pb.TagNumber(3)
  void clearMail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get password => $_getSZ(3);
  @$pb.TagNumber(4)
  set password($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPassword() => $_has(3);
  @$pb.TagNumber(4)
  void clearPassword() => clearField(4);
}

class StatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  StatusResponse._() : super();
  factory StatusResponse() => create();
  factory StatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StatusResponse clone() => StatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StatusResponse copyWith(void Function(StatusResponse) updates) => super.copyWith((message) => updates(message as StatusResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StatusResponse create() => StatusResponse._();
  StatusResponse createEmptyInstance() => create();
  static $pb.PbList<StatusResponse> createRepeated() => $pb.PbList<StatusResponse>();
  @$core.pragma('dart2js:noInline')
  static StatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StatusResponse>(create);
  static StatusResponse _defaultInstance;
}

class BalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  BalanceRequest._() : super();
  factory BalanceRequest() => create();
  factory BalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BalanceRequest clone() => BalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BalanceRequest copyWith(void Function(BalanceRequest) updates) => super.copyWith((message) => updates(message as BalanceRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BalanceRequest create() => BalanceRequest._();
  BalanceRequest createEmptyInstance() => create();
  static $pb.PbList<BalanceRequest> createRepeated() => $pb.PbList<BalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static BalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BalanceRequest>(create);
  static BalanceRequest _defaultInstance;
}

class BalanceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Balance', protoName: 'Balance')
    ..hasRequiredFields = false
  ;

  BalanceResponse._() : super();
  factory BalanceResponse() => create();
  factory BalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BalanceResponse clone() => BalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BalanceResponse copyWith(void Function(BalanceResponse) updates) => super.copyWith((message) => updates(message as BalanceResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BalanceResponse create() => BalanceResponse._();
  BalanceResponse createEmptyInstance() => create();
  static $pb.PbList<BalanceResponse> createRepeated() => $pb.PbList<BalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static BalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BalanceResponse>(create);
  static BalanceResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get balance => $_getSZ(0);
  @$pb.TagNumber(1)
  set balance($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => clearField(1);
}

class TransferRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ReceiverMail', protoName: 'ReceiverMail')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Amount', $pb.PbFieldType.O3, protoName: 'Amount')
    ..hasRequiredFields = false
  ;

  TransferRequest._() : super();
  factory TransferRequest() => create();
  factory TransferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferRequest clone() => TransferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferRequest copyWith(void Function(TransferRequest) updates) => super.copyWith((message) => updates(message as TransferRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransferRequest create() => TransferRequest._();
  TransferRequest createEmptyInstance() => create();
  static $pb.PbList<TransferRequest> createRepeated() => $pb.PbList<TransferRequest>();
  @$core.pragma('dart2js:noInline')
  static TransferRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferRequest>(create);
  static TransferRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiverMail => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiverMail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceiverMail() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiverMail() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get amount => $_getIZ(1);
  @$pb.TagNumber(2)
  set amount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);
}

class HistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SenderMail', protoName: 'SenderMail')
    ..hasRequiredFields = false
  ;

  HistoryRequest._() : super();
  factory HistoryRequest() => create();
  factory HistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HistoryRequest clone() => HistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HistoryRequest copyWith(void Function(HistoryRequest) updates) => super.copyWith((message) => updates(message as HistoryRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HistoryRequest create() => HistoryRequest._();
  HistoryRequest createEmptyInstance() => create();
  static $pb.PbList<HistoryRequest> createRepeated() => $pb.PbList<HistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static HistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HistoryRequest>(create);
  static HistoryRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderMail => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderMail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSenderMail() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderMail() => clearField(1);
}

class FiveFriendsHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FiveFriendsHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  FiveFriendsHistoryRequest._() : super();
  factory FiveFriendsHistoryRequest() => create();
  factory FiveFriendsHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FiveFriendsHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FiveFriendsHistoryRequest clone() => FiveFriendsHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FiveFriendsHistoryRequest copyWith(void Function(FiveFriendsHistoryRequest) updates) => super.copyWith((message) => updates(message as FiveFriendsHistoryRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FiveFriendsHistoryRequest create() => FiveFriendsHistoryRequest._();
  FiveFriendsHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<FiveFriendsHistoryRequest> createRepeated() => $pb.PbList<FiveFriendsHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static FiveFriendsHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FiveFriendsHistoryRequest>(create);
  static FiveFriendsHistoryRequest _defaultInstance;
}

class HistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SenderMail', protoName: 'SenderMail')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ReceiverMail', protoName: 'ReceiverMail')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Amount', $pb.PbFieldType.O3, protoName: 'Amount')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Time', protoName: 'Time')
    ..hasRequiredFields = false
  ;

  HistoryResponse._() : super();
  factory HistoryResponse() => create();
  factory HistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HistoryResponse clone() => HistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HistoryResponse copyWith(void Function(HistoryResponse) updates) => super.copyWith((message) => updates(message as HistoryResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HistoryResponse create() => HistoryResponse._();
  HistoryResponse createEmptyInstance() => create();
  static $pb.PbList<HistoryResponse> createRepeated() => $pb.PbList<HistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static HistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HistoryResponse>(create);
  static HistoryResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderMail => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderMail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSenderMail() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderMail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get receiverMail => $_getSZ(1);
  @$pb.TagNumber(2)
  set receiverMail($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReceiverMail() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiverMail() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get amount => $_getIZ(2);
  @$pb.TagNumber(3)
  set amount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get time => $_getI64(3);
  @$pb.TagNumber(4)
  set time($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearTime() => clearField(4);
}

class RefreshTokenRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RefreshTokenRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'RefreshToken', protoName: 'RefreshToken')
    ..hasRequiredFields = false
  ;

  RefreshTokenRequest._() : super();
  factory RefreshTokenRequest() => create();
  factory RefreshTokenRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RefreshTokenRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RefreshTokenRequest clone() => RefreshTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RefreshTokenRequest copyWith(void Function(RefreshTokenRequest) updates) => super.copyWith((message) => updates(message as RefreshTokenRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RefreshTokenRequest create() => RefreshTokenRequest._();
  RefreshTokenRequest createEmptyInstance() => create();
  static $pb.PbList<RefreshTokenRequest> createRepeated() => $pb.PbList<RefreshTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static RefreshTokenRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RefreshTokenRequest>(create);
  static RefreshTokenRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refreshToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set refreshToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefreshToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefreshToken() => clearField(1);
}

class LoginRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mail', protoName: 'Mail')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Password', protoName: 'Password')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Identifier', protoName: 'Identifier')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'DeviceName', protoName: 'DeviceName')
    ..hasRequiredFields = false
  ;

  LoginRequest._() : super();
  factory LoginRequest() => create();
  factory LoginRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginRequest clone() => LoginRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginRequest copyWith(void Function(LoginRequest) updates) => super.copyWith((message) => updates(message as LoginRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginRequest create() => LoginRequest._();
  LoginRequest createEmptyInstance() => create();
  static $pb.PbList<LoginRequest> createRepeated() => $pb.PbList<LoginRequest>();
  @$core.pragma('dart2js:noInline')
  static LoginRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginRequest>(create);
  static LoginRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mail => $_getSZ(0);
  @$pb.TagNumber(1)
  set mail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMail() => $_has(0);
  @$pb.TagNumber(1)
  void clearMail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get identifier => $_getSZ(2);
  @$pb.TagNumber(3)
  set identifier($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIdentifier() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdentifier() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get deviceName => $_getSZ(3);
  @$pb.TagNumber(4)
  set deviceName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDeviceName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceName() => clearField(4);
}

class LoginResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'AccessToken', protoName: 'AccessToken')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ExpiresOn', protoName: 'ExpiresOn')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'RefreshToken', protoName: 'RefreshToken')
    ..hasRequiredFields = false
  ;

  LoginResponse._() : super();
  factory LoginResponse() => create();
  factory LoginResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginResponse clone() => LoginResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginResponse copyWith(void Function(LoginResponse) updates) => super.copyWith((message) => updates(message as LoginResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginResponse create() => LoginResponse._();
  LoginResponse createEmptyInstance() => create();
  static $pb.PbList<LoginResponse> createRepeated() => $pb.PbList<LoginResponse>();
  @$core.pragma('dart2js:noInline')
  static LoginResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginResponse>(create);
  static LoginResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get expiresOn => $_getI64(1);
  @$pb.TagNumber(2)
  set expiresOn($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasExpiresOn() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpiresOn() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get refreshToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set refreshToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRefreshToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefreshToken() => clearField(3);
}

class UserInfoRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserInfoRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  UserInfoRequest._() : super();
  factory UserInfoRequest() => create();
  factory UserInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserInfoRequest clone() => UserInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserInfoRequest copyWith(void Function(UserInfoRequest) updates) => super.copyWith((message) => updates(message as UserInfoRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserInfoRequest create() => UserInfoRequest._();
  UserInfoRequest createEmptyInstance() => create();
  static $pb.PbList<UserInfoRequest> createRepeated() => $pb.PbList<UserInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static UserInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserInfoRequest>(create);
  static UserInfoRequest _defaultInstance;
}

class UserInfoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserInfoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'FirstName', protoName: 'FirstName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastName', protoName: 'LastName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mail', protoName: 'Mail')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ImageID', protoName: 'ImageID')
    ..hasRequiredFields = false
  ;

  UserInfoResponse._() : super();
  factory UserInfoResponse() => create();
  factory UserInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserInfoResponse clone() => UserInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserInfoResponse copyWith(void Function(UserInfoResponse) updates) => super.copyWith((message) => updates(message as UserInfoResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserInfoResponse create() => UserInfoResponse._();
  UserInfoResponse createEmptyInstance() => create();
  static $pb.PbList<UserInfoResponse> createRepeated() => $pb.PbList<UserInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static UserInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserInfoResponse>(create);
  static UserInfoResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastName => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastName() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastName() => clearField(2);

  @$pb.TagNumber(4)
  $core.String get mail => $_getSZ(2);
  @$pb.TagNumber(4)
  set mail($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasMail() => $_has(2);
  @$pb.TagNumber(4)
  void clearMail() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get imageID => $_getI64(3);
  @$pb.TagNumber(5)
  set imageID($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasImageID() => $_has(3);
  @$pb.TagNumber(5)
  void clearImageID() => clearField(5);
}

class AddFriendRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddFriendRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mail', protoName: 'Mail')
    ..hasRequiredFields = false
  ;

  AddFriendRequest._() : super();
  factory AddFriendRequest() => create();
  factory AddFriendRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddFriendRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddFriendRequest clone() => AddFriendRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddFriendRequest copyWith(void Function(AddFriendRequest) updates) => super.copyWith((message) => updates(message as AddFriendRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddFriendRequest create() => AddFriendRequest._();
  AddFriendRequest createEmptyInstance() => create();
  static $pb.PbList<AddFriendRequest> createRepeated() => $pb.PbList<AddFriendRequest>();
  @$core.pragma('dart2js:noInline')
  static AddFriendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddFriendRequest>(create);
  static AddFriendRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mail => $_getSZ(0);
  @$pb.TagNumber(1)
  set mail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMail() => $_has(0);
  @$pb.TagNumber(1)
  void clearMail() => clearField(1);
}

class RemoveFriendRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveFriendRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mail', protoName: 'Mail')
    ..hasRequiredFields = false
  ;

  RemoveFriendRequest._() : super();
  factory RemoveFriendRequest() => create();
  factory RemoveFriendRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveFriendRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveFriendRequest clone() => RemoveFriendRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveFriendRequest copyWith(void Function(RemoveFriendRequest) updates) => super.copyWith((message) => updates(message as RemoveFriendRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveFriendRequest create() => RemoveFriendRequest._();
  RemoveFriendRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveFriendRequest> createRepeated() => $pb.PbList<RemoveFriendRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveFriendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveFriendRequest>(create);
  static RemoveFriendRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mail => $_getSZ(0);
  @$pb.TagNumber(1)
  set mail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMail() => $_has(0);
  @$pb.TagNumber(1)
  void clearMail() => clearField(1);
}

class GetFollowersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFollowersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetFollowersRequest._() : super();
  factory GetFollowersRequest() => create();
  factory GetFollowersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFollowersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFollowersRequest clone() => GetFollowersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFollowersRequest copyWith(void Function(GetFollowersRequest) updates) => super.copyWith((message) => updates(message as GetFollowersRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFollowersRequest create() => GetFollowersRequest._();
  GetFollowersRequest createEmptyInstance() => create();
  static $pb.PbList<GetFollowersRequest> createRepeated() => $pb.PbList<GetFollowersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFollowersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFollowersRequest>(create);
  static GetFollowersRequest _defaultInstance;
}

class GetFriendsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFriendsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetFriendsRequest._() : super();
  factory GetFriendsRequest() => create();
  factory GetFriendsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFriendsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFriendsRequest clone() => GetFriendsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFriendsRequest copyWith(void Function(GetFriendsRequest) updates) => super.copyWith((message) => updates(message as GetFriendsRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetFriendsRequest create() => GetFriendsRequest._();
  GetFriendsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFriendsRequest> createRepeated() => $pb.PbList<GetFriendsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFriendsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFriendsRequest>(create);
  static GetFriendsRequest _defaultInstance;
}

class GenericUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GenericUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mail', protoName: 'Mail')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ImageID', protoName: 'ImageID')
    ..hasRequiredFields = false
  ;

  GenericUser._() : super();
  factory GenericUser() => create();
  factory GenericUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenericUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenericUser clone() => GenericUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenericUser copyWith(void Function(GenericUser) updates) => super.copyWith((message) => updates(message as GenericUser)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GenericUser create() => GenericUser._();
  GenericUser createEmptyInstance() => create();
  static $pb.PbList<GenericUser> createRepeated() => $pb.PbList<GenericUser>();
  @$core.pragma('dart2js:noInline')
  static GenericUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenericUser>(create);
  static GenericUser _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mail => $_getSZ(0);
  @$pb.TagNumber(1)
  set mail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMail() => $_has(0);
  @$pb.TagNumber(1)
  void clearMail() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get imageID => $_getI64(1);
  @$pb.TagNumber(2)
  set imageID($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasImageID() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageID() => clearField(2);
}

class SearchFriendRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchFriendRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Search', protoName: 'Search')
    ..hasRequiredFields = false
  ;

  SearchFriendRequest._() : super();
  factory SearchFriendRequest() => create();
  factory SearchFriendRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchFriendRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchFriendRequest clone() => SearchFriendRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchFriendRequest copyWith(void Function(SearchFriendRequest) updates) => super.copyWith((message) => updates(message as SearchFriendRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchFriendRequest create() => SearchFriendRequest._();
  SearchFriendRequest createEmptyInstance() => create();
  static $pb.PbList<SearchFriendRequest> createRepeated() => $pb.PbList<SearchFriendRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchFriendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchFriendRequest>(create);
  static SearchFriendRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get search => $_getSZ(0);
  @$pb.TagNumber(1)
  set search($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSearch() => $_has(0);
  @$pb.TagNumber(1)
  void clearSearch() => clearField(1);
}

class TopUsersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TopUsersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..pc<UserInfoResponse>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Users', $pb.PbFieldType.PM, protoName: 'Users', subBuilder: UserInfoResponse.create)
    ..hasRequiredFields = false
  ;

  TopUsersResponse._() : super();
  factory TopUsersResponse() => create();
  factory TopUsersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TopUsersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TopUsersResponse clone() => TopUsersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TopUsersResponse copyWith(void Function(TopUsersResponse) updates) => super.copyWith((message) => updates(message as TopUsersResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TopUsersResponse create() => TopUsersResponse._();
  TopUsersResponse createEmptyInstance() => create();
  static $pb.PbList<TopUsersResponse> createRepeated() => $pb.PbList<TopUsersResponse>();
  @$core.pragma('dart2js:noInline')
  static TopUsersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TopUsersResponse>(create);
  static TopUsersResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserInfoResponse> get users => $_getList(0);
}

class TopUsersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TopUsersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  TopUsersRequest._() : super();
  factory TopUsersRequest() => create();
  factory TopUsersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TopUsersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TopUsersRequest clone() => TopUsersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TopUsersRequest copyWith(void Function(TopUsersRequest) updates) => super.copyWith((message) => updates(message as TopUsersRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TopUsersRequest create() => TopUsersRequest._();
  TopUsersRequest createEmptyInstance() => create();
  static $pb.PbList<TopUsersRequest> createRepeated() => $pb.PbList<TopUsersRequest>();
  @$core.pragma('dart2js:noInline')
  static TopUsersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TopUsersRequest>(create);
  static TopUsersRequest _defaultInstance;
}

class VerifyRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mail', protoName: 'Mail')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..hasRequiredFields = false
  ;

  VerifyRequest._() : super();
  factory VerifyRequest() => create();
  factory VerifyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyRequest clone() => VerifyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyRequest copyWith(void Function(VerifyRequest) updates) => super.copyWith((message) => updates(message as VerifyRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyRequest create() => VerifyRequest._();
  VerifyRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyRequest> createRepeated() => $pb.PbList<VerifyRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyRequest>(create);
  static VerifyRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mail => $_getSZ(0);
  @$pb.TagNumber(1)
  set mail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMail() => $_has(0);
  @$pb.TagNumber(1)
  void clearMail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);
}

class CodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mail', protoName: 'Mail')
    ..hasRequiredFields = false
  ;

  CodeRequest._() : super();
  factory CodeRequest() => create();
  factory CodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CodeRequest clone() => CodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CodeRequest copyWith(void Function(CodeRequest) updates) => super.copyWith((message) => updates(message as CodeRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CodeRequest create() => CodeRequest._();
  CodeRequest createEmptyInstance() => create();
  static $pb.PbList<CodeRequest> createRepeated() => $pb.PbList<CodeRequest>();
  @$core.pragma('dart2js:noInline')
  static CodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CodeRequest>(create);
  static CodeRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mail => $_getSZ(0);
  @$pb.TagNumber(1)
  set mail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMail() => $_has(0);
  @$pb.TagNumber(1)
  void clearMail() => clearField(1);
}

class ImagesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImagesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'images')
    ..hasRequiredFields = false
  ;

  ImagesResponse._() : super();
  factory ImagesResponse() => create();
  factory ImagesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImagesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImagesResponse clone() => ImagesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImagesResponse copyWith(void Function(ImagesResponse) updates) => super.copyWith((message) => updates(message as ImagesResponse)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImagesResponse create() => ImagesResponse._();
  ImagesResponse createEmptyInstance() => create();
  static $pb.PbList<ImagesResponse> createRepeated() => $pb.PbList<ImagesResponse>();
  @$core.pragma('dart2js:noInline')
  static ImagesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImagesResponse>(create);
  static ImagesResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get images => $_getList(0);
}

class ImagesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImagesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ImagesRequest._() : super();
  factory ImagesRequest() => create();
  factory ImagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImagesRequest clone() => ImagesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImagesRequest copyWith(void Function(ImagesRequest) updates) => super.copyWith((message) => updates(message as ImagesRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImagesRequest create() => ImagesRequest._();
  ImagesRequest createEmptyInstance() => create();
  static $pb.PbList<ImagesRequest> createRepeated() => $pb.PbList<ImagesRequest>();
  @$core.pragma('dart2js:noInline')
  static ImagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImagesRequest>(create);
  static ImagesRequest _defaultInstance;
}

class ResetPasswordRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResetPasswordRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'payeet'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mail', protoName: 'Mail')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Password', protoName: 'Password')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Code', protoName: 'Code')
    ..hasRequiredFields = false
  ;

  ResetPasswordRequest._() : super();
  factory ResetPasswordRequest() => create();
  factory ResetPasswordRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetPasswordRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResetPasswordRequest clone() => ResetPasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResetPasswordRequest copyWith(void Function(ResetPasswordRequest) updates) => super.copyWith((message) => updates(message as ResetPasswordRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResetPasswordRequest create() => ResetPasswordRequest._();
  ResetPasswordRequest createEmptyInstance() => create();
  static $pb.PbList<ResetPasswordRequest> createRepeated() => $pb.PbList<ResetPasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static ResetPasswordRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResetPasswordRequest>(create);
  static ResetPasswordRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mail => $_getSZ(0);
  @$pb.TagNumber(1)
  set mail($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMail() => $_has(0);
  @$pb.TagNumber(1)
  void clearMail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => clearField(3);
}

