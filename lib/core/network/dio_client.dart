// core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:social_media/core/error/dio_exception_handler.dart';

import 'ApiCalls.dart';

class DioClient implements ApiCalls {
  late final Dio dio;
  String baseUrl;

  DioClient({required this.baseUrl}) {

    dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      }
    ));

    dio.interceptors.add(LogInterceptor(
    request: true,
    error: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    ));
  }



  @override
  Future<Map<String, dynamic>> get(String url, {Map<String, dynamic>? header,Map<String, dynamic>? queryParameters,}) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: header,
        ),
      );
      return _validateResponseData(response.data);
    } on DioException catch (e) {
      throw DioExceptionHandler.handleError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic>? body, {Map<String, dynamic>? header}) async {
    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: header),
      );
      print('lololololo ${response.data}');
      print('lololololo ${response.statusCode}');
      print('lololololo ${response.statusMessage}');

      if(response.statusCode == 201)
        return {'statusCode': 201};

      return _validateResponseData(response.data);
    } on DioException catch (e) {

      print('lololololo222222222 ${e.error}');
      print('lololololo2222222 ${e.response!.statusCode}');
      print('lololololo2222222 ${e.response!.statusMessage}');

      print(e.response!.data);
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
  Future<Map<String, dynamic>> delete(String url, {Map<String, dynamic>? header}) async {
    try {
      final response = await dio.request(
        url,
        options: Options(
          headers: header,
          method: 'DELETE',
        ),
      );
      return _validateResponseData(response.data);
    } on DioException catch (e) {
      throw DioExceptionHandler.handleError(e);
    }
  }

  Map<String, dynamic> _validateResponseData(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    } else if (data == null) {
      throw Exception('Response data is null');
    } else if (data is int || data is String || data is double || data is bool || data is List || data is Map<String, dynamic>) {
      return {
        'data': data
      };
    } else {
      throw Exception('Invalid response format: Expected Map<String, dynamic>, but got ${data.runtimeType}');
    }
  }
}
