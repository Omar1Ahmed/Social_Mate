// lib/data/datasources/report_data_source.dart

import 'package:dio/dio.dart';
import 'package:social_media/core/network/dio_client.dart';
import 'package:social_media/features/admin/report_details/data/model/report_models.dart';

class ReportDataSource {
  final DioClient dio;

  ReportDataSource({required this.dio});

  Future<ReportResponse> fetchReportData() async {
    try {
      final response = await dio.get('/reports');

      if (response['statusCode'] == 200) {
        return ReportResponse.fromJson(response);
      } else {
        throw Exception('Failed to load report data: Invalid response format');
      }
    } on DioError catch (e) {
      // Handle Dio-specific errors (e.g., network issues)
      if (e.response != null) {
        print('Error Response: ${e.response?.data}');
        print('Status Code: ${e.response?.statusCode}');
      } else {
        print('Error Message: ${e.message}');
      }
      rethrow; // Rethrow the error for higher-level handling
    } catch (e) {
      // Handle other unexpected errors
      print('Unexpected Error: $e');
      rethrow;
    }
  }
}
