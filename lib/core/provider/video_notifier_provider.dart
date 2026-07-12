import 'dart:async';


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../device/device_info.dart';
import '../device/device_service.dart';
import '../model/video_model.dart';
import '../provider/device_provider.dart';
import 'video_repository.dart';

/// Video feed state (no code-generation; no .g.dart)
final videoProvider = AsyncNotifierProvider<VideoNotifier, List<VideoModel>>(
  VideoNotifier.new,
);



class VideoNotifier extends AsyncNotifier<List<VideoModel>> {
  @override
  FutureOr<List<VideoModel>> build() {
    return ref.watch(videoRepositoryProvider).fetchVideos();
  }

  Future<void> refreshFeed() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() =>
        ref.watch(videoRepositoryProvider).fetchVideos());
  }
}

/// VIP activation state (duration_days result)
final vipActivationProvider =
    AsyncNotifierProvider<VipActivationNotifier, String?>(
  VipActivationNotifier.new,
);

class VipActivationNotifier extends AsyncNotifier<String?> {
  @override
  FutureOr<String?> build() => null;

  Future<void> claimKey(String key) async {
    final trimmed = key.trim();
    if (trimmed.isEmpty) {
      state = AsyncValue.error(
        ArgumentError('VIP key is required'),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // Device id comes from device_provider via deviceIdProvider.
      final deviceId = await ref.read(deviceIdProvider.future);
      return await ref
          .watch(videoRepositoryProvider)
          .activateVipKey(key: trimmed, deviceId: deviceId);
    });
  }
}


