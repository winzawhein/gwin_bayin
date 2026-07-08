import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ThemeNotifier extends StateNotifier<bool> {


  ThemeNotifier() : super(true); // true => dark

  void setDark(bool value) => state = value;

  void toggle() => state = !state;
}


final isDarkProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});


