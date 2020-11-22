///
//  Generated code. Do not modify.
//  source: payeet.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class StatusResponse_code extends $pb.ProtobufEnum {
  static const StatusResponse_code SUCCESS = StatusResponse_code._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUCCESS');
  static const StatusResponse_code WORNG_CREDS = StatusResponse_code._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WORNG_CREDS');
  static const StatusResponse_code INVALID_MAIL = StatusResponse_code._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVALID_MAIL');
  static const StatusResponse_code INVALID_SESSION = StatusResponse_code._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVALID_SESSION');

  static const $core.List<StatusResponse_code> values = <StatusResponse_code> [
    SUCCESS,
    WORNG_CREDS,
    INVALID_MAIL,
    INVALID_SESSION,
  ];

  static final $core.Map<$core.int, StatusResponse_code> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StatusResponse_code valueOf($core.int value) => _byValue[value];

  const StatusResponse_code._($core.int v, $core.String n) : super(v, n);
}

