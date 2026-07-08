import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme_notifier.dart';
import 'navigation_notifier.dart';

/// Compatibility layer so legacy `lib/features/*_screen.dart` files keep
/// compiling while the refactor is in progress.

// Old names expected by legacy screens.
final themeProvider = Provider<ThemeMode>((ref) {
  final isDark = ref.watch(isDarkProvider);
  return isDark ? ThemeMode.dark : ThemeMode.light;
});

final navigationProvider = navigationIndexProvider;



