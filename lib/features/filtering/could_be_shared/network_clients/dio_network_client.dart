// this supposed to be a base configration for dio client (abstracted & could be overrided)
// the normal class made by omar is also ok , but the abstracted could be for real or mock api
// i liked the generic type functions

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media/features/filtering/could_be_shared/fake_end_points/fake_end_points.dart';

abstract class DioNetworkClient {
  late Dio dio;

//TODO: i need to do a revision on this constructor
//TODO: remove kdebug
  DioNetworkClient() {
    dio = Dio(
      BaseOptions(
          baseUrl: FakeEndPoints.baseUrl,
          connectTimeout: Duration(seconds: 5),
          sendTimeout: Duration(seconds: 5),
          contentType: 'application/json'),
    );

    dio.interceptors.add(LogInterceptor(
        request: true,
        error: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
  }
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.post(path, data: data);
      return response;
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.put(path, data: data);
      return response;
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await dio.delete(path);
      return response;
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  void handleError(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          if (kDebugMode) {
            print('Connection timeout');
          }
          break;
        case DioExceptionType.sendTimeout:
          if (kDebugMode) {
            print('Send timeout');
          }
          break;
        case DioExceptionType.receiveTimeout:
          if (kDebugMode) {
            print('Receive timeout');
          }
          break;
        case DioExceptionType.badResponse:
          if (kDebugMode) {
            print(
                'Response error: ${error.response?.statusCode} - ${error.response?.statusMessage}');
          }
          break;
        case DioExceptionType.cancel:
          if (kDebugMode) {
            print('Request canceled');
          }
          break;
        case DioExceptionType.unknown:
          if (kDebugMode) {
            print('Unexpected error: ${error.message}');
          }
          break;
        default:
        if (kDebugMode) {
          print('Unhandled DioExceptionType: ${error.type}');
        }
        break;  
      }
    } else {
      if (kDebugMode) {
        print('Unknown error: $error');
      }
    }
  }
}
