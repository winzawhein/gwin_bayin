import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import 'device_info.dart';

class DeviceService {
  static const String _deviceIdKey = 'gwin_bayin_device_id';

  final Dio _dio = Dio();

  // Future<String> getOrCreateDeviceId({
  //   required String fallbackPrefix,
  // }) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final existing = prefs.getString(_deviceIdKey);
  //   if (existing != null && existing.trim().isNotEmpty) {
  //     return existing;
  //   }

  //   final id = '$fallbackPrefix-${_newRandomId()}';
  //   await prefs.setString(_deviceIdKey, id);
  //   return id;
  // }


  Future<void> initDevice({required String fallbackPrefix}) async {
    // final deviceId = await getOrCreateDeviceId(fallbackPrefix: fallbackPrefix);

    // Local Dio to avoid Riverpod cycles.
    _dio.options.baseUrl = AppConfig.baseUrl;

    final deviceInfo = await collectDeviceInfo();
    final packageInfo = await _collectPackageInfo();

    // final deviceId = await getOrCreateDeviceId(fallbackPrefix: fallbackPrefix);

    final payload = {
      'device_id': deviceInfo.deviceId,
      'device_model': deviceInfo.deviceModel,

      'device_manufacturer': deviceInfo.manufacturer,
      'device_os_version': deviceInfo.osVersion,
      'device_brand': deviceInfo.brand,
      // package fields
      // 'package_name': packageInfo.packageName,
      // 'app_version': packageInfo.version,
      // 'build_number': packageInfo.buildNumber,
    };
    {
    // "device_id" :"test",
    // "device_model" :"test",
    // "device_manufacturer": "test",
    // "device_os_version" : "14",
    // "device_brand" :"samsung"
}

    final start = DateTime.now();
    try {
      // Only log for the init call so it doesn’t spam.
      // (Full request/response logging is handled by dio_client interceptor.)
      // ignore: avoid_print
      log('[DeviceService] POST ${AppConfig.baseUrl}/api/init-device device_id=${deviceInfo.deviceId}');

log("payload Init>>>> $payload");
      final res = await _dio.post('/api/init-device', data: payload);

      final ms = DateTime.now().difference(start).inMilliseconds;
      // ignore: avoid_print
      log('[DeviceService] init-device status=${res.statusCode} duration=${ms}ms');
    } on DioException catch (e) {
      final ms = DateTime.now().difference(start).inMilliseconds;
      // ignore: avoid_print
      log('[DeviceService] init-device failed duration=${ms}ms err=${e.message}');
      rethrow;
    }
  }

  

  Future<_CollectedPackageInfo> _collectPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return _CollectedPackageInfo(
        packageName: info.packageName,
        version: info.version,
        buildNumber: info.buildNumber,
      );
    } catch (_) {
      return const _CollectedPackageInfo(
        packageName: 'unknown',
        version: 'unknown',
        buildNumber: 'unknown',
      );
    }
  }

  String _newRandomId() {
    final now = DateTime.now().microsecondsSinceEpoch;
    return now.toRadixString(16);
  }
}




class _CollectedPackageInfo {
  final String packageName;
  final String version;
  final String buildNumber;

  const _CollectedPackageInfo({
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });
}


