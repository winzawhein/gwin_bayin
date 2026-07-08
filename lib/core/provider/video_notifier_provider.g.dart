// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VideoNotifier)
final videoProvider = VideoNotifierProvider._();

final class VideoNotifierProvider
    extends $AsyncNotifierProvider<VideoNotifier, List<VideoModel>> {
  VideoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'videoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$videoNotifierHash();

  @$internal
  @override
  VideoNotifier create() => VideoNotifier();
}

String _$videoNotifierHash() => r'27efb29687c48010c2254cc15599f0d8362989cc';

abstract class _$VideoNotifier extends $AsyncNotifier<List<VideoModel>> {
  FutureOr<List<VideoModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<VideoModel>>, List<VideoModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<VideoModel>>, List<VideoModel>>,
              AsyncValue<List<VideoModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(VipActivationNotifier)
final vipActivationProvider = VipActivationNotifierProvider._();

final class VipActivationNotifierProvider
    extends $NotifierProvider<VipActivationNotifier, AsyncValue<int?>> {
  VipActivationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vipActivationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vipActivationNotifierHash();

  @$internal
  @override
  VipActivationNotifier create() => VipActivationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<int?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<int?>>(value),
    );
  }
}

String _$vipActivationNotifierHash() =>
    r'8f3eae7b044e43e24be2050503b65a6f61e4060d';

abstract class _$VipActivationNotifier extends $Notifier<AsyncValue<int?>> {
  AsyncValue<int?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<int?>, AsyncValue<int?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int?>, AsyncValue<int?>>,
              AsyncValue<int?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
