import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/model/setting_model_response.dart';
import '../../core/network/api_exception.dart';
import '../../core/network/client/dio_client.dart';
import '../../core/provider/device_provider.dart';
import '../../features/vip/domain/vip_status.dart';

import 'app_boot_state_dto.dart';

final appBootRepositoryProvider = Provider<AppBootRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AppBootRepository(ref: ref, dio: dio);
});

class AppBootRepository {
  final Ref ref;
  final Dio _dio;

  AppBootRepository({required this.ref, required Dio dio}) : _dio = dio;

  Future<void> initDevice() async {
    // Keep splash/loading visible by awaiting boot initialization.
    await ref
        .read(deviceServiceProvider)
        .initDevice(fallbackPrefix: 'gwin-bayin');
  }

  Future<VersionCheckDto> versionCheck() async {
    final res = await _dio.get('/api/version-check');
    final data = res.data;
    log("Version>>> $data");
    if (data is Map<String, dynamic>) {
      return VersionCheckDto.fromJson(data);
    }

    throw ApiException(message: 'Invalid server response');
  }

  Future<VipStatus> vipCheck() async {
    final deviceId = await ref.read(deviceIdProvider.future);

    final res = await _dio.post(
      '/api/vip/check',
      data: {'device_id': deviceId},
    );

    final data = res.data;
    log("Version>>>  Vip $data");

    if (data is Map<String, dynamic>) {
      return VipStatus.fromJson(data);
    }

    throw ApiException(message: 'Invalid server response');
  }
  Future<SettingModelResponse> settings() async {

    final res = await _dio.get(
      '/api/vip/settings',
    );

    final data = res.data;
    log("Setting>>>  Vip $data");

    if (data is Map<String, dynamic>) {
      return SettingModelResponse.fromJson(data);
    }

    throw ApiException(message: 'Invalid server response');
  }
}
