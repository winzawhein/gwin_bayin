

import 'package:device_info_plus/device_info_plus.dart';

Future<_CollectedDeviceInfo> collectDeviceInfo() async {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

    // Platform-specific fallbacks.
    final base = _CollectedDeviceInfo(
      deviceId: 'unknown',
      deviceModel: 'unknown',
      manufacturer: 'unknown',
      osVersion: 'unknown',
      brand: 'unknown',
    );

    try {
      return base.copyWith(
        deviceId: androidInfo.id,
        deviceModel: androidInfo.model ?? base.deviceModel,
        manufacturer: androidInfo.manufacturer ?? base.manufacturer,
        osVersion: androidInfo.version.release ?? base.osVersion,
        brand: androidInfo.brand ?? base.brand,
      );
    } catch (_) {
      // ignore and fall back
    }

    // try {
    //   final ios = await plugin.iosInfo;
    //   return base.copyWith(
    //     deviceModel: ios.utsname.machine ?? base.deviceModel,
    //     manufacturer: 'Apple',
    //     osVersion: ios.systemVersion ?? base.osVersion,
    //     brand: 'Apple',
    //   );
    // } catch (_) {
    //   // ignore and return base
    // }


    return base;
  }
  class _CollectedDeviceInfo {
  final String deviceId;
  final String deviceModel;
  final String manufacturer;
  final String osVersion;
  final String brand;

  const _CollectedDeviceInfo({
    required this.deviceModel,
    required this.manufacturer,
    required this.osVersion,
    required this.brand,
    required this.deviceId
  });

  _CollectedDeviceInfo copyWith({
    String? deviceModel,
    String? manufacturer,
    String? osVersion,
    String? brand,
    String? deviceId
  }) {
    return _CollectedDeviceInfo(
      deviceId: deviceId??this.deviceId,
      deviceModel: deviceModel ?? this.deviceModel,
      manufacturer: manufacturer ?? this.manufacturer,
      osVersion: osVersion ?? this.osVersion,
      brand: brand ?? this.brand,
    );
  }
}