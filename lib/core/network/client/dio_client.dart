import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api_exception.dart';

/// App-wide Dio instance.
///
/// NOTE: per backend sheet, every `/api/...` call needs these headers:
/// - User-Agent: GwinBayinApp
/// - x-app-token: [APP_AUTH_TOKEN] (placeholder for now)
/// - x-device-id: [device unique]
/// - x-app-version: 1.0.0
///
/// `x-real-user: true` is only required for video list endpoints,
/// so we add it only when callers request it via [realUser] flag.
import '../../../core/provider/device_provider.dart';
import '../../../core/provider/app_auth_provider.dart';
import '../../config/app_config.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final deviceId = await ref.read(deviceIdProvider.future);
        final token =
            '47ca0305433c596d8e9990af06adcc09a967f5a63fb78419bf49e118cf69524f';
        options.headers.addAll({
          'User-Agent': 'GwinBayinApp',
          // 'x-app-token': '47ca0305433c596d8e9990af06adcc09a967',
          'Authorization': 'Bearer $token',
          'x-device-id': deviceId,
          // deviceId.isEmpty ? 'test' : deviceId,
          'x-app-version': '1.0.0',
          'x-real-user': 'true',
          // 'Accept':'application/json'
        });

        // Dynamic check using your helper method configuration
        // final realUser = (options.extra['realUser'] as bool?) == true;
        // if (realUser) {
        //   options.headers['x-real-user'] = 'true'; // MUST BE A STRING
        // } else {
        //   options.headers.remove('x-real-user');
        // }

        log('[API] --> ${options.method.toUpperCase()} ${options.uri}');
        log('[API] Headers: ${options.headers}'); // Useful for debugging
        log('[API] extra: ${options.extra}'); // Useful for debugging

        return handler.next(options);
      },
      //   {
      //     // final appAuthToken = ref.read(appAuthTokenProvider);
      //    final deviceId = await ref.read(deviceIdProvider.future);

      //   options.headers.addAll({
      //     'User-Agent': 'GwinBayinApp',
      //     'Authorization': 'Bearer 47ca0305433c596d8e9990af06adcc09a967',
      //     'x-app-token': '47ca0305433c596d8e9990af06adcc09a967',
      //     'x-device-id': deviceId.isEmpty ? 'test' : deviceId, // Match postman 'test' if empty
      //     'x-app-version': '1.0.0',
      //     'x-real-user': true
      //   });

      //   // REMOVE or comment out this line if your server doesn't use standard Bearer tokens:
      //   // options.headers['Authorization'] = 'Bearer 47ca0305433c596d8e9990af06adcc09a967';

      //   // final realUser = (options.extra['realUser'] as bool?) == true;
      //   // if (realUser) {
      //   //   options.headers['x-real-user'] = 'true';
      //   // } else {
      //   //   options.headers.remove('x-real-user');
      //   // }

      //   log('[API] --> ${options.method.toUpperCase()} ${options.uri}');
      //   return handler.next(options);

      // // ... rest of your code remains the same

      //   },
      onResponse: (response, handler) {
        final path = response.requestOptions.path;
        final isApi = path.startsWith('/api/') || path.startsWith('api/');
        if (isApi) {
          // ignore: avoid_print
          log(
            '[API] <-- ${response.statusCode} ${response.requestOptions.uri}',
          );
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        final path = e.requestOptions.path;
        final isApi = path.startsWith('/api/') || path.startsWith('api/');
        if (isApi) {
          final status = e.response?.statusCode;
          // ignore: avoid_print
          log(
            '[API] !! ${status ?? '-'} ${e.requestOptions.uri} err=${e.message}',
          );
        }

        return handler.next(
          DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            type: e.type,
            error: ApiException.fromDioError(e),
          ),
        );
      },
    ),
  );

  return dio;
});

// final dioProvider = Provider<Dio>((ref) {
//   final dio = Dio(
//     BaseOptions(
//       baseUrl: AppConfig.baseUrl,
//       connectTimeout: const Duration(seconds: 15),
//       receiveTimeout: const Duration(seconds: 15),
//     ),
//   );

//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         final deviceId = await ref.read(deviceIdProvider.future);

//         options.headers.addAll({
//           'User-Agent': 'GwinBayinApp',
//           'x-app-token': '47ca0305433c596d8e9990af06adcc09a967',
//           'Authorization': 'Bearer 47ca0305433c596d8e9990af06adcc09a967',
//           'x-device-id': deviceId.isEmpty ? 'test' : deviceId,
//           'x-app-version': '1.0.0',
//         });

//         // Dynamic check using your helper method configuration
//         final realUser = (options.extra['realUser'] as bool?) == true;
//         if (realUser) {
//           options.headers['x-real-user'] = 'true'; // MUST BE A STRING
//         } else {
//           options.headers.remove('x-real-user');
//         }

//         log('[API] --> ${options.method.toUpperCase()} ${options.uri}');
//         log('[API] Headers: ${options.headers}'); // Useful for debugging
//         log('[API] extra: ${options.extra}'); // Useful for debugging

//         return handler.next(options);
//       },
//       onResponse: (response, handler) => handler.next(response),
//       onError: (DioException e, handler) => handler.next(e),
//     ),
//   );

//   return dio;
// });

/// Helper for repositories: mark the request as a "real user" request.
///
/// Usage:
/// `dio.get('/api/videos', queryParameters: ..., options: Options(extra: {'realUser': true}))`
/// Apply `x-real-user: true` for endpoints that require it.
///
/// We use `options.extra` so the Dio interceptor can inject the header.
Map<String, dynamic> dioRealUserExtra() => {'realUser': true};
