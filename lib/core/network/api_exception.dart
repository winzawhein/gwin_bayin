import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioError(DioException error) {
    String message = 'Something went wrong';
    final int? statusCode = error.response?.statusCode;

    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      final maybeMessage = data['message'];
      if (maybeMessage is String && maybeMessage.trim().isNotEmpty) {
        message = maybeMessage;
      }
    } else {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          message = 'Connection timed out. Please try again.';
          break;
        case DioExceptionType.badResponse:
          if (statusCode == 401) {
            message = 'Device registration required.';
          } else if (statusCode == 403) {
            message = 'Access Forbidden: Invalid Token/User-Agent.';
          } else if (statusCode == 429) {
            message = 'Too many requests. Slow down.';
          } else if (statusCode != null) {
            message = 'Request failed with status code $statusCode.';
          }
          break;
        default:
          message = 'No internet connection detected.';
      }
    }

    return ApiException(message: message, statusCode: statusCode);
  }
}

