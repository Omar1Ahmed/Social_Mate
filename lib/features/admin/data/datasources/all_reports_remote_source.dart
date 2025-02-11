import 'package:dio/dio.dart';
import 'package:social_media/core/network/dio_client.dart';
import 'package:social_media/features/admin/data/models/main_report_model.dart';

abstract class AllReportsRemoteSource {
  Future<List<MainReportModel>> getAllReports(Map<String, dynamic> queryParams,
      {required String token});
}

class AllReportsRemoteSourceImpl implements AllReportsRemoteSource {
  final DioClient dioClient;

  AllReportsRemoteSourceImpl({required this.dioClient});

  @override
  Future<List<MainReportModel>> getAllReports(
    Map<String, dynamic> queryParams, {
    required String token,
  }) async {
    try {

      final response = await dioClient.get(
        '/reports',
        queryParameters: queryParams,
        header: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );


      if (response['data'] == null) {
        throw Exception('Invalid response format: data is missing');
      }


      final List<dynamic> data = response['data'] ?? [];
      final int total = response['total']?.toInt() ?? 0;


      final List<MainReportModel> reportList = data
          .map((report) => MainReportModel(
                data: [ReportData.fromJson(report)],
                total: total,
              ))
          .toList();

      return reportList;
    } on DioException catch (e, stackTrace) {
      print('DioException: $e\nStackTrace: $stackTrace');

      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final errorMessage = e.response!.data?['message'] ?? e.message;
        throw Exception('HTTP Error $statusCode: $errorMessage');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } on FormatException catch (e, stackTrace) {
      print('FormatException: $e\nStackTrace: $stackTrace');
      throw Exception('Invalid response format: ${e.message}');
    } catch (e, stackTrace) {
      print('Unexpected Error: $e\nStackTrace: $stackTrace');
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
