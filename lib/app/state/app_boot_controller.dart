import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_state_models.dart';
import 'app_boot_repositories.dart';

final appBootControllerProvider =
    AsyncNotifierProvider<AppBootController, AppBootState>(
      () => AppBootController(),
    );

class AppBootController extends AsyncNotifier<AppBootState> {
  @override
  Future<AppBootState> build() async {
    final repo = ref.watch(appBootRepositoryProvider);

    // await repo.initDevice();

    final version = await repo.versionCheck();
    final vip = await repo.vipCheck();
    ref.read(versionProvider.notifier).state = version.latestVersion ?? '';
    final settings = await repo.settings();
    ref.read(aboutUsProvider.notifier).state = settings.data?.aboutUsUrl??'';
    final needsUpdate =
        (version.updateRequired == true) || (version.forceUpdate == true);
    // log("Version>>> ${version.forceUpdate} >>> $vip");
    return AppBootState(
      needsForceUpdate: (version.forceUpdate == true),
      updateRequired: needsUpdate,
      latestVersion: version.latestVersion,
      vip: vip,
    );
  }
}
