import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../device/device_info.dart';
import '../device/device_service.dart';

final deviceServiceProvider = Provider<DeviceService>((ref) {
  return DeviceService();
});

/// Provides a stable app-level device id (persisted) for auth headers.
final deviceIdProvider = FutureProvider<String>((ref) async {
  final deviceInfo = await collectDeviceInfo();
  return deviceInfo.deviceId;
});




