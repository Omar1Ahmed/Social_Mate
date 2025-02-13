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

        return _validateResponseData(response.data);
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

        // Debug: Print the full response
        print('Response Data: ${response.data}');
        print('Status Code: ${response.statusCode}');
        print('Status Message: ${response.statusMessage}');

        // Handle different response types
        dynamic responseData = response.data;
        if (responseData is String && responseData.isNotEmpty) {
          try {
            // Parse JSON string to Map<dynamic, dynamic>
            final parsedJson = jsonDecode(responseData);
            // Cast to Map<String, dynamic>
            responseData = parsedJson as Map<String, dynamic>;
          } catch (e) {
            print('JSON Parsing or Casting Error: $e');
            throw Exception('Invalid JSON response: ${response.data}');
          }
        } else if (responseData == null || responseData.toString().isEmpty) {
          // Return an empty map for empty responses
          responseData = <String, dynamic>{};
        } else if (responseData is int) {
          // Wrap integer response in a map
          responseData = {
            'value': responseData,
            'statusCode': response.statusCode, // Include the status code here
          };
        }

        // Always return the response body for successful responses
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 204) {
          return responseData;
        } else {
          throw DioExceptionHandler.handleError(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              type: DioExceptionType.badResponse,
            ),
          );
        }
      } on DioException catch (e) {
        // Handle Dio errors
        print('DioException Error: ${e.error}');
        print('Status Code: ${e.response?.statusCode}');
        print('Status Message: ${e.response?.statusMessage}');
        print('Response Data: ${e.response?.data}');

        throw DioExceptionHandler.handleError(e);
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic>? body,
      {Map<String, dynamic>? header}) async {
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
        if (response.statusCode == 204) return {'statusCode': 204};

        return _validateResponseData(response.data);
      } on DioException catch (e) {
        throw DioExceptionHandler.handleError(e);
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String url,
      {Map<String, dynamic>? header}) async {
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

        if (response.statusCode == 204) return {'statusCode': 204};

        return _validateResponseData(response.data);
      } on DioException catch (e) {
        throw DioExceptionHandler.handleError(e);
      }
    } else {
      throw Exception('No internet connection');
    }
  }

  Map<String, dynamic> _validateResponseData(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    } else if (data == null) {
      throw Exception('Response data is null');
    } else if (data is int ||
        data is String ||
        data is double ||
        data is bool ||
        data is List ||
        data is Map<String, dynamic>) {
      return {'data': data};
    } else {
      throw Exception(
          'Invalid response format: Expected Map<String, dynamic>, but got ${data.runtimeType}');
    }
  }
}
