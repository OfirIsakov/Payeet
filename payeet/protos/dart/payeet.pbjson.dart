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

const historyRequest$json = const {
  '1': 'historyRequest',
  '2': const [
    const {'1': 'Index', '3': 1, '4': 1, '5': 5, '10': 'Index'},
    const {'1': 'SenderID', '3': 2, '4': 1, '5': 9, '10': 'SenderID'},
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
    const {'1': 'User_ID', '3': 3, '4': 1, '5': 9, '10': 'UserID'},
  ],
};

