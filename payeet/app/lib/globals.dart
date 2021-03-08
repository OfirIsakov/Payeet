import 'package:Payeet/grpc/protos/payeet.pbgrpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Payeet/grpc/payeetClient.dart';
import 'package:grpc/grpc.dart';
import 'package:flutter/material.dart';
import 'secure_storage.dart';

class Globals {
  // this is the index of the current page.
  static var selectedIndex = StateProvider((ref) => 0);
  static var balance = StateProvider((ref) => 0);
  static var transfer_email = StateProvider((ref) => "");

  static var themeMode = StateProvider((ref) => ThemeMode.system);

  static List<HistoryResponse> transHistory = [];
  static var radioIndex = StateProvider((ref) => 1);

  static var client = PayeetClient(PayeetChannel(
    ClientChannel(
      'api.payeet.xyz',
      port: 6969,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    ),
  ));

  /// [updateThemeMode] changes [Globals.themeMode] for a given index.
  ///
  /// 0 -> darkTheme
  /// 1 -> lightTheme
  /// 2 -> system theme.
  static void updateThemeMode(int index, BuildContext context) {

    switch (index) {
      case 0:
        {
          context.read(themeMode).state = ThemeMode.dark;
          break;
        }
      case 1:
        {
          context.read(themeMode).state = ThemeMode.light;
          break;
        }
      case 2:
        {
          context.read(themeMode).state = ThemeMode.system;
          break;
        }
    }

    SecureStorage.writeSecureData('ThemeIndex', index.toString());
  }
}
