import '../../features/vip/domain/vip_status.dart';

class AppBootState {
  final bool needsForceUpdate;
  final bool updateRequired;
  final String? latestVersion;
  final VipStatus vip;

  const AppBootState({
    required this.needsForceUpdate,
    required this.updateRequired,
    required this.latestVersion,
    required this.vip,
  });
}

