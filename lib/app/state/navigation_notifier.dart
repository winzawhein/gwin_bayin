import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class NavigationNotifier extends StateNotifier<int> {



  NavigationNotifier() : super(0);

  void changeIndex(int index) => state = index;
}

final navigationIndexProvider =
    StateNotifierProvider<NavigationNotifier, int>((ref) {
  return NavigationNotifier();
});

