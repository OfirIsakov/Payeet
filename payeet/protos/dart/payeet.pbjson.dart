///
//  Generated code. Do not modify.
//  source: payeet.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const LoginRequest_S$json = const {
  '1': 'LoginRequest_S',
  '2': const [
    const {'1': 'Session', '3': 1, '4': 1, '5': 9, '10': 'Session'},
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
    const {'1': 'FirstName', '3': 1, '4': 1, '5': 9, '10': 'FirstName'},
    const {'1': 'LastName', '3': 2, '4': 1, '5': 9, '10': 'LastName'},
    const {'1': 'Session', '3': 3, '4': 1, '5': 9, '10': 'Session'},
    const {'1': 'User_ID', '3': 4, '4': 1, '5': 9, '10': 'UserID'},
  ],
};

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
  '2': const [
    const {'1': 'StatusCode', '3': 1, '4': 1, '5': 14, '6': '.payeet.StatusResponse.code', '10': 'StatusCode'},
    const {'1': 'Message', '3': 2, '4': 1, '5': 9, '10': 'Message'},
  ],
  '4': const [StatusResponse_code$json],
};

const StatusResponse_code$json = const {
  '1': 'code',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'WORNG_CREDS', '2': 1},
    const {'1': 'INVALID_MAIL', '2': 2},
    const {'1': 'INVALID_SESSION', '2': 3},
  ],
};

const BalanceRequest$json = const {
  '1': 'BalanceRequest',
  '2': const [
    const {'1': 'User_ID', '3': 1, '4': 1, '5': 9, '10': 'UserID'},
    const {'1': 'Session', '3': 2, '4': 1, '5': 9, '10': 'Session'},
  ],
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
    const {'1': 'SenderID', '3': 2, '4': 1, '5': 9, '10': 'SenderID'},
    const {'1': 'Session', '3': 3, '4': 1, '5': 9, '10': 'Session'},
  ],
};

const historyRequest$json = const {
  '1': 'historyRequest',
  '2': const [
    const {'1': 'Index', '3': 1, '4': 1, '5': 5, '10': 'Index'},
    const {'1': 'SenderID', '3': 2, '4': 1, '5': 9, '10': 'SenderID'},
    const {'1': 'Session', '3': 3, '4': 1, '5': 9, '10': 'Session'},
  ],
};

