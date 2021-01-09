import 'package:flutter_riverpod/flutter_riverpod.dart';

class Globals {
  // this is the index of the current page.
  static var selectedIndex = StateProvider((ref) => 0);
  static var email = StateProvider((ref) => "");
}