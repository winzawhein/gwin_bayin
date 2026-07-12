import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/video_model.dart';
import '../network/api_exception.dart';
import '../network/client/dio_client.dart';

final videoRepositoryProvider = Provider<VideoRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return VideoRepository(dio);
});


class VideoRepository {
  final Dio _dio;

  VideoRepository(this._dio);

  Future<List<VideoModel>> fetchVideos() async {
    try {
      final response = await _dio.get(
        '/api/videos',
        options: Options(extra: dioRealUserExtra()),
      );


      final data = response.data;
      // log(data);
      if (data is Map<String, dynamic>) {
        final items = data['data'];
        if (items is List) {
          return items
              .whereType<Map<String, dynamic>>()
              .map(VideoModel.fromJson)
              .toList();
        }
      }

      return const [];
    } on DioException catch (e) {
      if (e.error is ApiException) {
        throw e.error as ApiException;
      }
      throw ApiException(message: e.message ?? 'Request failed', statusCode: e.response?.statusCode);
    }
  }
    Future<String> activateVipKey({required String key, required String deviceId}) async {
    try {
      final response = await _dio.post('/api/vip/activate', data: {
        'key': key,
        'device_id': deviceId,
      });

      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data['message'];
        // ScaffoldMessenger.maybeOf(context).showSnackBar(snackBar)
        // final duration = data['duration'];
        // if (duration is int) return duration;
        // if (duration is num) return duration.toInt();
      }

      throw ApiException(message: 'Invalid server response');
    } on DioException catch (e) {
      if (e.error is ApiException) {
        throw e.error as ApiException;
      }
      throw ApiException(message: e.message ?? 'Request failed', statusCode: e.response?.statusCode);
    }
  }
}