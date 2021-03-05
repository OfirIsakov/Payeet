///
//  Generated code. Do not modify.
//  source: payeet.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use registerRequestDescriptor instead')
const RegisterRequest$json = const {
  '1': 'RegisterRequest',
  '2': const [
    const {'1': 'FirstName', '3': 1, '4': 1, '5': 9, '10': 'FirstName'},
    const {'1': 'LastName', '3': 2, '4': 1, '5': 9, '10': 'LastName'},
    const {'1': 'Mail', '3': 3, '4': 1, '5': 9, '10': 'Mail'},
    const {'1': 'Password', '3': 4, '4': 1, '5': 9, '10': 'Password'},
  ],
};

/// Descriptor for `RegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerRequestDescriptor = $convert.base64Decode('Cg9SZWdpc3RlclJlcXVlc3QSHAoJRmlyc3ROYW1lGAEgASgJUglGaXJzdE5hbWUSGgoITGFzdE5hbWUYAiABKAlSCExhc3ROYW1lEhIKBE1haWwYAyABKAlSBE1haWwSGgoIUGFzc3dvcmQYBCABKAlSCFBhc3N3b3Jk');
@$core.Deprecated('Use statusResponseDescriptor instead')
const StatusResponse$json = const {
  '1': 'StatusResponse',
};

/// Descriptor for `StatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusResponseDescriptor = $convert.base64Decode('Cg5TdGF0dXNSZXNwb25zZQ==');
@$core.Deprecated('Use balanceRequestDescriptor instead')
const BalanceRequest$json = const {
  '1': 'BalanceRequest',
};

/// Descriptor for `BalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List balanceRequestDescriptor = $convert.base64Decode('Cg5CYWxhbmNlUmVxdWVzdA==');
@$core.Deprecated('Use balanceResponseDescriptor instead')
const BalanceResponse$json = const {
  '1': 'BalanceResponse',
  '2': const [
    const {'1': 'Balance', '3': 1, '4': 1, '5': 9, '10': 'Balance'},
  ],
};

/// Descriptor for `BalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List balanceResponseDescriptor = $convert.base64Decode('Cg9CYWxhbmNlUmVzcG9uc2USGAoHQmFsYW5jZRgBIAEoCVIHQmFsYW5jZQ==');
@$core.Deprecated('Use transferRequestDescriptor instead')
const TransferRequest$json = const {
  '1': 'TransferRequest',
  '2': const [
    const {'1': 'ReceiverMail', '3': 1, '4': 1, '5': 9, '10': 'ReceiverMail'},
    const {'1': 'Amount', '3': 2, '4': 1, '5': 5, '10': 'Amount'},
  ],
};

/// Descriptor for `TransferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferRequestDescriptor = $convert.base64Decode('Cg9UcmFuc2ZlclJlcXVlc3QSIgoMUmVjZWl2ZXJNYWlsGAEgASgJUgxSZWNlaXZlck1haWwSFgoGQW1vdW50GAIgASgFUgZBbW91bnQ=');
@$core.Deprecated('Use historyRequestDescriptor instead')
const HistoryRequest$json = const {
  '1': 'HistoryRequest',
  '2': const [
    const {'1': 'SenderMail', '3': 1, '4': 1, '5': 9, '10': 'SenderMail'},
  ],
};

/// Descriptor for `HistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyRequestDescriptor = $convert.base64Decode('Cg5IaXN0b3J5UmVxdWVzdBIeCgpTZW5kZXJNYWlsGAEgASgJUgpTZW5kZXJNYWls');
@$core.Deprecated('Use fiveFriendsHistoryRequestDescriptor instead')
const FiveFriendsHistoryRequest$json = const {
  '1': 'FiveFriendsHistoryRequest',
};

/// Descriptor for `FiveFriendsHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fiveFriendsHistoryRequestDescriptor = $convert.base64Decode('ChlGaXZlRnJpZW5kc0hpc3RvcnlSZXF1ZXN0');
@$core.Deprecated('Use historyResponseDescriptor instead')
const HistoryResponse$json = const {
  '1': 'HistoryResponse',
  '2': const [
    const {'1': 'SenderMail', '3': 1, '4': 1, '5': 9, '10': 'SenderMail'},
    const {'1': 'ReceiverMail', '3': 2, '4': 1, '5': 9, '10': 'ReceiverMail'},
    const {'1': 'Amount', '3': 3, '4': 1, '5': 5, '10': 'Amount'},
    const {'1': 'Time', '3': 4, '4': 1, '5': 3, '10': 'Time'},
  ],
};

/// Descriptor for `HistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyResponseDescriptor = $convert.base64Decode('Cg9IaXN0b3J5UmVzcG9uc2USHgoKU2VuZGVyTWFpbBgBIAEoCVIKU2VuZGVyTWFpbBIiCgxSZWNlaXZlck1haWwYAiABKAlSDFJlY2VpdmVyTWFpbBIWCgZBbW91bnQYAyABKAVSBkFtb3VudBISCgRUaW1lGAQgASgDUgRUaW1l');
@$core.Deprecated('Use refreshTokenRequestDescriptor instead')
const RefreshTokenRequest$json = const {
  '1': 'RefreshTokenRequest',
  '2': const [
    const {'1': 'RefreshToken', '3': 1, '4': 1, '5': 9, '10': 'RefreshToken'},
  ],
};

/// Descriptor for `RefreshTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshTokenRequestDescriptor = $convert.base64Decode('ChNSZWZyZXNoVG9rZW5SZXF1ZXN0EiIKDFJlZnJlc2hUb2tlbhgBIAEoCVIMUmVmcmVzaFRva2Vu');
@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = const {
  '1': 'LoginRequest',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
    const {'1': 'Password', '3': 2, '4': 1, '5': 9, '10': 'Password'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode('CgxMb2dpblJlcXVlc3QSEgoETWFpbBgBIAEoCVIETWFpbBIaCghQYXNzd29yZBgCIAEoCVIIUGFzc3dvcmQ=');
@$core.Deprecated('Use verifyRequestDescriptor instead')
const VerifyRequest$json = const {
  '1': 'VerifyRequest',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `VerifyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyRequestDescriptor = $convert.base64Decode('Cg1WZXJpZnlSZXF1ZXN0EhIKBE1haWwYASABKAlSBE1haWwSEgoEY29kZRgCIAEoCVIEY29kZQ==');
@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = const {
  '1': 'LoginResponse',
  '2': const [
    const {'1': 'AccessToken', '3': 1, '4': 1, '5': 9, '10': 'AccessToken'},
    const {'1': 'ExpiresOn', '3': 2, '4': 1, '5': 3, '10': 'ExpiresOn'},
    const {'1': 'RefreshToken', '3': 3, '4': 1, '5': 9, '10': 'RefreshToken'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode('Cg1Mb2dpblJlc3BvbnNlEiAKC0FjY2Vzc1Rva2VuGAEgASgJUgtBY2Nlc3NUb2tlbhIcCglFeHBpcmVzT24YAiABKANSCUV4cGlyZXNPbhIiCgxSZWZyZXNoVG9rZW4YAyABKAlSDFJlZnJlc2hUb2tlbg==');
@$core.Deprecated('Use userInfoRequestDescriptor instead')
const UserInfoRequest$json = const {
  '1': 'UserInfoRequest',
};

/// Descriptor for `UserInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userInfoRequestDescriptor = $convert.base64Decode('Cg9Vc2VySW5mb1JlcXVlc3Q=');
@$core.Deprecated('Use userInfoResponseDescriptor instead')
const UserInfoResponse$json = const {
  '1': 'UserInfoResponse',
  '2': const [
    const {'1': 'FirstName', '3': 1, '4': 1, '5': 9, '10': 'FirstName'},
    const {'1': 'LastName', '3': 2, '4': 1, '5': 9, '10': 'LastName'},
    const {'1': 'User_ID', '3': 4, '4': 1, '5': 9, '10': 'UserID'},
  ],
};

/// Descriptor for `UserInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userInfoResponseDescriptor = $convert.base64Decode('ChBVc2VySW5mb1Jlc3BvbnNlEhwKCUZpcnN0TmFtZRgBIAEoCVIJRmlyc3ROYW1lEhoKCExhc3ROYW1lGAIgASgJUghMYXN0TmFtZRIXCgdVc2VyX0lEGAQgASgJUgZVc2VySUQ=');
@$core.Deprecated('Use addFriendRequestDescriptor instead')
const AddFriendRequest$json = const {
  '1': 'AddFriendRequest',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
  ],
};

/// Descriptor for `AddFriendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addFriendRequestDescriptor = $convert.base64Decode('ChBBZGRGcmllbmRSZXF1ZXN0EhIKBE1haWwYASABKAlSBE1haWw=');
@$core.Deprecated('Use removeFriendRequestDescriptor instead')
const RemoveFriendRequest$json = const {
  '1': 'RemoveFriendRequest',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
  ],
};

/// Descriptor for `RemoveFriendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFriendRequestDescriptor = $convert.base64Decode('ChNSZW1vdmVGcmllbmRSZXF1ZXN0EhIKBE1haWwYASABKAlSBE1haWw=');
@$core.Deprecated('Use getFollowersRequestDescriptor instead')
const GetFollowersRequest$json = const {
  '1': 'GetFollowersRequest',
};

/// Descriptor for `GetFollowersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFollowersRequestDescriptor = $convert.base64Decode('ChNHZXRGb2xsb3dlcnNSZXF1ZXN0');
@$core.Deprecated('Use getFollowersResponseDescriptor instead')
const GetFollowersResponse$json = const {
  '1': 'GetFollowersResponse',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
  ],
};

/// Descriptor for `GetFollowersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFollowersResponseDescriptor = $convert.base64Decode('ChRHZXRGb2xsb3dlcnNSZXNwb25zZRISCgRNYWlsGAEgASgJUgRNYWls');
@$core.Deprecated('Use getFriendsRequestDescriptor instead')
const GetFriendsRequest$json = const {
  '1': 'GetFriendsRequest',
};

/// Descriptor for `GetFriendsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFriendsRequestDescriptor = $convert.base64Decode('ChFHZXRGcmllbmRzUmVxdWVzdA==');
@$core.Deprecated('Use getFriendsResponseDescriptor instead')
const GetFriendsResponse$json = const {
  '1': 'GetFriendsResponse',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
  ],
};

/// Descriptor for `GetFriendsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFriendsResponseDescriptor = $convert.base64Decode('ChJHZXRGcmllbmRzUmVzcG9uc2USEgoETWFpbBgBIAEoCVIETWFpbA==');
@$core.Deprecated('Use searchFriendRequestDescriptor instead')
const SearchFriendRequest$json = const {
  '1': 'SearchFriendRequest',
  '2': const [
    const {'1': 'search', '3': 1, '4': 1, '5': 9, '10': 'search'},
  ],
};

/// Descriptor for `SearchFriendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchFriendRequestDescriptor = $convert.base64Decode('ChNTZWFyY2hGcmllbmRSZXF1ZXN0EhYKBnNlYXJjaBgBIAEoCVIGc2VhcmNo');
@$core.Deprecated('Use searchFriendResponseDescriptor instead')
const SearchFriendResponse$json = const {
  '1': 'SearchFriendResponse',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
  ],
};

/// Descriptor for `SearchFriendResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchFriendResponseDescriptor = $convert.base64Decode('ChRTZWFyY2hGcmllbmRSZXNwb25zZRISCgRNYWlsGAEgASgJUgRNYWls');
@$core.Deprecated('Use topUsersResponseDescriptor instead')
const TopUsersResponse$json = const {
  '1': 'TopUsersResponse',
  '2': const [
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.payeet.UserInfoResponse', '10': 'users'},
  ],
};

/// Descriptor for `TopUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topUsersResponseDescriptor = $convert.base64Decode('ChBUb3BVc2Vyc1Jlc3BvbnNlEi4KBXVzZXJzGAEgAygLMhgucGF5ZWV0LlVzZXJJbmZvUmVzcG9uc2VSBXVzZXJz');
@$core.Deprecated('Use topUsersRequestDescriptor instead')
const TopUsersRequest$json = const {
  '1': 'TopUsersRequest',
};

/// Descriptor for `TopUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topUsersRequestDescriptor = $convert.base64Decode('Cg9Ub3BVc2Vyc1JlcXVlc3Q=');
