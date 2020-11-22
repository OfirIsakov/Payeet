///
//  Generated code. Do not modify.
//  source: payeet.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const LoginRequest_S$json = const {
  '1': 'LoginRequest_S',
  '2': const [
    const {'1': 'session', '3': 1, '4': 1, '5': 9, '10': 'session'},
  ],
};

const LoginRequest$json = const {
  '1': 'LoginRequest',
  '2': const [
    const {'1': 'mail', '3': 1, '4': 1, '5': 9, '10': 'mail'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

const LoginResponse$json = const {
  '1': 'LoginResponse',
  '2': const [
    const {'1': 'FirstName', '3': 1, '4': 1, '5': 9, '10': 'FirstName'},
    const {'1': 'LastName', '3': 2, '4': 1, '5': 9, '10': 'LastName'},
    const {'1': 'session', '3': 3, '4': 1, '5': 9, '10': 'session'},
    const {'1': 'user_ID', '3': 4, '4': 1, '5': 9, '10': 'userID'},
  ],
};

const RegisterRequest$json = const {
  '1': 'RegisterRequest',
  '2': const [
    const {'1': 'FirstName', '3': 1, '4': 1, '5': 9, '10': 'FirstName'},
    const {'1': 'LastName', '3': 2, '4': 1, '5': 9, '10': 'LastName'},
    const {'1': 'mail', '3': 3, '4': 1, '5': 9, '10': 'mail'},
    const {'1': 'password', '3': 4, '4': 1, '5': 9, '10': 'password'},
  ],
};

const StatusResponse$json = const {
  '1': 'StatusResponse',
  '2': const [
    const {'1': 'StatusCode', '3': 1, '4': 1, '5': 14, '6': '.payeet.StatusResponse.code', '10': 'StatusCode'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
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
    const {'1': 'user_ID', '3': 1, '4': 1, '5': 9, '10': 'userID'},
    const {'1': 'session', '3': 2, '4': 1, '5': 9, '10': 'session'},
  ],
};

const BalanceResponse$json = const {
  '1': 'BalanceResponse',
  '2': const [
    const {'1': 'balance', '3': 1, '4': 1, '5': 9, '10': 'balance'},
  ],
};

const TransferRequest$json = const {
  '1': 'TransferRequest',
  '2': const [
    const {'1': 'receiverMail', '3': 1, '4': 1, '5': 9, '10': 'receiverMail'},
    const {'1': 'senderID', '3': 2, '4': 1, '5': 9, '10': 'senderID'},
    const {'1': 'session', '3': 3, '4': 1, '5': 9, '10': 'session'},
  ],
};

const historyRequest$json = const {
  '1': 'historyRequest',
  '2': const [
    const {'1': 'index', '3': 1, '4': 1, '5': 5, '10': 'index'},
    const {'1': 'senderID', '3': 2, '4': 1, '5': 9, '10': 'senderID'},
    const {'1': 'session', '3': 3, '4': 1, '5': 9, '10': 'session'},
  ],
};

