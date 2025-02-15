// core/network/dio_client.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:social_media/core/error/dio_exception_handler.dart';
import 'package:social_media/core/helper/Connectivity/connectivity_helper.dart';

import 'ApiCalls.dart';

class DioClient implements ApiCalls {
  late final Dio dio;
  String baseUrl;

  DioClient({required this.baseUrl}) {
    dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {
          'Content-Type': 'application/json',
        }));

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
  Future<Map<String, dynamic>> get(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? header}) async {
    final isConnected = await ConnectivityHelper.isConnected();
    if (isConnected) {
      try {
        final response = await dio.get(
          url,
          queryParameters: queryParameters,
          options: Options(
            headers: header,
          ),
        );


        return _validateResponseData(response);
      } on DioException catch (e) {
        throw DioExceptionHandler.handleError(e);
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<Map<String, dynamic>> post(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? header}) async {
    final isConnected = await ConnectivityHelper.isConnected();
    if (isConnected) {
      try {
        final response = await dio.post(
          url,
          data: body,
          options: Options(headers: header),
        );
        print('lololololo ${response.data}');
        print('lololololo ${response.data.runtimeType}');
        print('lololololo ${response.statusCode}');
        print('lololololo ${response.statusMessage}');



        return _validateResponseData(response);
      } on DioException catch (e) {
        print('lololololo222222222 ${e.error}');
        print('lololololo2222222 ${e.response!.statusCode}');
        print('lololololo2222222 ${e.response!.statusMessage}');

        print(e.response!.data);
        throw DioExceptionHandler.handleError(e);
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic>? body, {Map<String, dynamic>? header}) async {
    final isConnected = await ConnectivityHelper.isConnected();
    if (isConnected) {
      try {
        final response = await dio.put(
          url,
          data: body,
          options: Options(
            headers: header,
          ),
        );


        return _validateResponseData(response);
      } on DioException catch (e) {
        throw DioExceptionHandler.handleError(e);
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String url, {Map<String, dynamic>? header}) async {
    final isConnected = await ConnectivityHelper.isConnected();
    if (isConnected) {
      try {
        final response = await dio.request(
          url,
          options: Options(
            headers: header,
            method: 'DELETE',
          ),
        );



        return _validateResponseData(response);
      } on DioException catch (e) {
        throw DioExceptionHandler.handleError(e);
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  Map<String, dynamic> _validateResponseData(Response response) {

    print('response data ${response.data}');
    print('response data ${response.data == null}');
    print('response data ${response.data.toString().isEmpty}');
    print('response data ${response.data is Map<String, dynamic>}');

    if (response.data is Map<String, dynamic>) {
      return response.data;
    }else if(response.data.toString().isEmpty && (response.statusCode == 204 || response.statusCode == 201 || response.statusCode == 200) ){

        return {
          'statusCode': response.statusCode
        };

    } else if (response.data == null) {
      throw Exception('Response data is null');
    } else if (response.data is int ||
        response.data is String ||
        response.data is double ||
        response.data is bool ||
        response.data is List ||
        response.data is Map<String, dynamic>) {
      return {'data': response.data};
    } else {
      throw Exception(
          'Invalid response format: Expected Map<String, dynamic>, but got ${response.runtimeType}');
    }
  }
}
