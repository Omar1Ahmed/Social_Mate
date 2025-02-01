// core/network/dio_client.dart
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient() : dio = Dio() {
    // Base configuration
    dio.options.baseUrl = 'https://your-api-url.com/';
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }
}