import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/screens/splash_screen.dart';

import '../app/state/theme_notifier.dart';

class GwinBayinApp extends ConsumerWidget {
  const GwinBayinApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);

    return MaterialApp(
      title: 'Gwin Bayin',
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFE53935),
          surface: Colors.white,
          onSurface: Colors.black87,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121315),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE53935),
          surface: const Color(0xFF1E2022),
          onSurface: Colors.white,
        ),
      ),
      home: const SplashScreen(),

    );
  }
}

