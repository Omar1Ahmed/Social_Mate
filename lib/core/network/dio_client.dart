// core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:social_media/core/error/dio_exception_handler.dart';

import 'ApiCalls.dart';

class DioClient implements ApiCalls {
  final Dio dio;

  DioClient({required this.dio});



  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await dio.get(url);
      return response.data;
    } on DioException catch (e) {
      throw DioExceptionHandler.handleError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic>? body) async {
    try {
      final response = await dio.post(url, data: body);
      return response.data;
    } on DioException catch (e) {
      throw DioExceptionHandler.handleError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic>? body) async {
    try {
      final response = await dio.put(url, data: body);
      return response.data;
    } on DioException catch (e) {
      throw DioExceptionHandler.handleError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String url) async {
    try {
      final response = await dio.delete(url);
      return response.data;
    } on DioException catch (e) {
     throw DioExceptionHandler.handleError(e);
    }
  }


}