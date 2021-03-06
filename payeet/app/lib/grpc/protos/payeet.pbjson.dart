///
//  Generated code. Do not modify.
//  source: payeet.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const RegisterRequest$json = const {
  '1': 'RegisterRequest',
  '2': const [
    const {'1': 'FirstName', '3': 1, '4': 1, '5': 9, '10': 'FirstName'},
    const {'1': 'LastName', '3': 2, '4': 1, '5': 9, '10': 'LastName'},
    const {'1': 'Mail', '3': 3, '4': 1, '5': 9, '10': 'Mail'},
    const {'1': 'Password', '3': 4, '4': 1, '5': 9, '10': 'Password'},
  ],
};

const StatusResponse$json = const {
  '1': 'StatusResponse',
};

const BalanceRequest$json = const {
  '1': 'BalanceRequest',
};

const BalanceResponse$json = const {
  '1': 'BalanceResponse',
  '2': const [
    const {'1': 'Balance', '3': 1, '4': 1, '5': 9, '10': 'Balance'},
  ],
};

const TransferRequest$json = const {
  '1': 'TransferRequest',
  '2': const [
    const {'1': 'ReceiverMail', '3': 1, '4': 1, '5': 9, '10': 'ReceiverMail'},
    const {'1': 'Amount', '3': 2, '4': 1, '5': 5, '10': 'Amount'},
  ],
};

const HistoryRequest$json = const {
  '1': 'HistoryRequest',
  '2': const [
    const {'1': 'SenderMail', '3': 1, '4': 1, '5': 9, '10': 'SenderMail'},
  ],
};

const FiveFriendsHistoryRequest$json = const {
  '1': 'FiveFriendsHistoryRequest',
};

const HistoryResponse$json = const {
  '1': 'HistoryResponse',
  '2': const [
    const {'1': 'SenderMail', '3': 1, '4': 1, '5': 9, '10': 'SenderMail'},
    const {'1': 'ReceiverMail', '3': 2, '4': 1, '5': 9, '10': 'ReceiverMail'},
    const {'1': 'Amount', '3': 3, '4': 1, '5': 5, '10': 'Amount'},
    const {'1': 'Time', '3': 4, '4': 1, '5': 3, '10': 'Time'},
  ],
};

const RefreshTokenRequest$json = const {
  '1': 'RefreshTokenRequest',
  '2': const [
    const {'1': 'RefreshToken', '3': 1, '4': 1, '5': 9, '10': 'RefreshToken'},
  ],
};

const LoginRequest$json = const {
  '1': 'LoginRequest',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
    const {'1': 'Password', '3': 2, '4': 1, '5': 9, '10': 'Password'},
  ],
};

const LoginResponse$json = const {
  '1': 'LoginResponse',
  '2': const [
    const {'1': 'AccessToken', '3': 1, '4': 1, '5': 9, '10': 'AccessToken'},
    const {'1': 'ExpiresOn', '3': 2, '4': 1, '5': 3, '10': 'ExpiresOn'},
    const {'1': 'RefreshToken', '3': 3, '4': 1, '5': 9, '10': 'RefreshToken'},
  ],
};

const UserInfoRequest$json = const {
  '1': 'UserInfoRequest',
};

const UserInfoResponse$json = const {
  '1': 'UserInfoResponse',
  '2': const [
    const {'1': 'FirstName', '3': 1, '4': 1, '5': 9, '10': 'FirstName'},
    const {'1': 'LastName', '3': 2, '4': 1, '5': 9, '10': 'LastName'},
    const {'1': 'Mail', '3': 4, '4': 1, '5': 9, '10': 'Mail'},
  ],
};

const AddFriendRequest$json = const {
  '1': 'AddFriendRequest',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
  ],
};

const RemoveFriendRequest$json = const {
  '1': 'RemoveFriendRequest',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
  ],
};

const GetFollowersRequest$json = const {
  '1': 'GetFollowersRequest',
};

const GetFollowersResponse$json = const {
  '1': 'GetFollowersResponse',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
  ],
};

const GetFriendsRequest$json = const {
  '1': 'GetFriendsRequest',
};

const GetFriendsResponse$json = const {
  '1': 'GetFriendsResponse',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
  ],
};

const SearchFriendRequest$json = const {
  '1': 'SearchFriendRequest',
  '2': const [
    const {'1': 'Search', '3': 1, '4': 1, '5': 9, '10': 'Search'},
  ],
};

const SearchFriendResponse$json = const {
  '1': 'SearchFriendResponse',
  '2': const [
    const {'1': 'Mail', '3': 1, '4': 1, '5': 9, '10': 'Mail'},
  ],
};

const TopUsersResponse$json = const {
  '1': 'TopUsersResponse',
  '2': const [
    const {'1': 'Users', '3': 1, '4': 3, '5': 11, '6': '.payeet.UserInfoResponse', '10': 'Users'},
  ],
};

const TopUsersRequest$json = const {
  '1': 'TopUsersRequest',
};

