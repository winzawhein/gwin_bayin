import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/app_boot_controller.dart';
import '../state/app_state_models.dart';
import 'main_shell_screen.dart';
import '../ui_screens/force_update_screen.dart';


class AppLoadingScreen extends ConsumerWidget {
  const AppLoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boot = ref.watch(appBootControllerProvider);
        // return const MainShellScreen();

    return boot.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, st) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Color(0xFFE53935), size: 64),
                  const SizedBox(height: 16),
                  Text(
                    err.toString(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      data: (AppBootState state) {
        if (state.needsForceUpdate) {
          return ForceUpdateScreen(updateMessage: null, updateUrl: null);
        }
        return const MainShellScreen();
      },
    );
  }
}

