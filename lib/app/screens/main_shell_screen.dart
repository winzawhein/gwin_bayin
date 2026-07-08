import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/state/navigation_notifier.dart';
import '../../app/state/theme_notifier.dart';
import '../../app/providers/nav_visibility_provider.dart';
import '../../app/providers/scroll_nav_controller_provider.dart';
import '../../shared/widgets/custom_floating_nav_bar.dart';
import '../../shared/widgets/scroll_nav_listener.dart';

import '../../features/home/presentation/home_sliver_view.dart';
import '../../features/vip/presentation/vip_sliver_view.dart';
import '../../features/downloads/presentation/downloads_sliver_view.dart';
import '../../features/settings/presentation/settings_sliver_view.dart';

class MainShellScreen extends ConsumerWidget {
  const MainShellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentNavIndex = ref.watch(navigationIndexProvider);
    final isDark = ref.watch(isDarkProvider);
    final tabControllers = ref.watch(tabScrollControllersProvider);
    final navVisible = ref.watch(navVisibleProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: currentNavIndex,
              children: [
                // HOME
                Stack(
                  children: [
                    HomeSliverView(controller: tabControllers.home),
                    ScrollNavListener(controller: tabControllers.home),
                  ],
                ),
                // VIP
                Stack(
                  children: [
                    VipSliverView(controller: tabControllers.vip),
                    ScrollNavListener(controller: tabControllers.vip),
                  ],
                ),
                // DOWNLOADS
                Stack(
                  children: [
                    DownloadsSliverView(
                        controller: tabControllers.downloads),
                    ScrollNavListener(
                        controller: tabControllers.downloads),
                  ],
                ),
                // SETTINGS
                Stack(
                  children: [
                    SettingsSliverView(
                        controller: tabControllers.settings),
                    ScrollNavListener(
                        controller: tabControllers.settings),
                  ],
                ),
              ],
            ),

            // Shared floating bottom navigation
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: CustomFloatingNavBar(visible: navVisible),
            ),

          ],
        ),
      ),
    );
  }
}

