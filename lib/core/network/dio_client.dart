// core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:social_media/core/error/dio_exception_handler.dart';

import 'ApiCalls.dart';

class DioClient implements ApiCalls {
  final Dio dio;
  DioClient({required this.dio});

  @override
  Future<Map<String, dynamic>> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: queryParameters,
        ),
      );
      return _validateResponseData(response.data);
    } on DioException catch (e) {
      throw DioExceptionHandler.handleError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic>? body, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: queryParameters),
      );
      return _validateResponseData(response.data);
    } on DioException catch (e) {
      throw DioExceptionHandler.handleError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic>? body, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.put(
        url,
        data: body,
        options: Options(
          headers: queryParameters,
        ),
      );
      return _validateResponseData(response.data);
    } on DioException catch (e) {
      throw DioExceptionHandler.handleError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.delete(
        url,
        options: Options(
          headers: queryParameters,
        ),
      );
      return _validateResponseData(response.data);
    } on DioException catch (e) {
      throw DioExceptionHandler.handleError(e);
    }
  }

  /// Validates the response data and ensures it is a Map<String, dynamic>
  Map<String, dynamic> _validateResponseData(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    } else if (data == null) {
      throw Exception('Response data is null');
    } else if (data is int) {
      return {
        'data': data
      };
    } else if (data is String) {
      return {
        'data': data
      };
    } else if (data is List) {
      return {
        'data': data
      };
    } else if (data is double) {
      return {
        'data': data
      };
    } else if (data is bool) {
      return {
        'data': data
      };
    } else {
      throw Exception('Invalid response format: Expected Map<String, dynamic>, but got ${data.runtimeType}');
    }
  }
}
