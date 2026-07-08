import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/video_model.dart';
import 'video_repository.dart';

part 'video_notifier_provider.g.dart';

@riverpod
class VideoNotifier extends _$VideoNotifier {
  @override
  FutureOr<List<VideoModel>> build() {
    return ref.watch(videoRepositoryProvider).fetchVideos();
  }

  Future<void> refreshFeed() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.watch(videoRepositoryProvider).fetchVideos());
  }
}

@riverpod
class VipActivationNotifier extends _$VipActivationNotifier {
  @override
  AsyncValue<int?> build() => const AsyncValue.data(null);

  Future<void> claimKey(String key) async {
    final trimmed = key.trim();
    if (trimmed.isEmpty) {
      state = AsyncValue.error(ArgumentError('VIP key is required'), StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: replace with secure storage/device info.
      const String currentDevice = 'unique_device_hardware_id_abc123';
      return await ref
          .watch(videoRepositoryProvider)
          .activateVipKey(key: trimmed, deviceId: currentDevice);
    });
  }
}

