- [ ] Read and understand existing failing code paths (video_notifier_provider.dart, repository/client/providers).
- [ ] Fix missing/incorrect Riverpod generator parts (e.g., `part 'video_notifier.g.dart';` and imports).
- [ ] Implement missing dependencies (ApiException, Dio client, VideoRepository/provider, VideoModel if needed) so `videoRepositoryProvider` exists.
- [ ] Run `flutter pub run build_runner build --delete-conflicting-outputs`.
- [ ] Run `flutter analyze` and `flutter test` (if available).
- [ ] Verify app builds: `flutter build apk` or `flutter run`.

