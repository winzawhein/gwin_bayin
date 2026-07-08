import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds scroll controllers for each tab so the floating nav can
/// react to scroll position.
class TabScrollControllerState {
  final ScrollController home;
  final ScrollController vip;
  final ScrollController downloads;
  final ScrollController settings;

  const TabScrollControllerState({
    required this.home,
    required this.vip,
    required this.downloads,
    required this.settings,
  });
}

final tabScrollControllersProvider =
    Provider<TabScrollControllerState>((ref) {
  // Controllers are created once for the provider lifetime.
  // (ProviderScope in main.)
  final home = ScrollController();
  final vip = ScrollController();
  final downloads = ScrollController();
  final settings = ScrollController();

  ref.onDispose(() {
    home.dispose();
    vip.dispose();
    downloads.dispose();
    settings.dispose();
  });

  return TabScrollControllerState(
    home: home,
    vip: vip,
    downloads: downloads,
    settings: settings,
  );
});

