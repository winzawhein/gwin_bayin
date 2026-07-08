import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class NavVisibilityNotifier extends StateNotifier<bool> {



  NavVisibilityNotifier() : super(true);

  void show() => state = true;
  void hide() => state = false;
}

final navVisibleProvider =
    StateNotifierProvider<NavVisibilityNotifier, bool>((ref) {
  return NavVisibilityNotifier();
});

