// lib/data/datasources/report_data_source.dart

import 'package:social_media/core/network/dio_client.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/userMainDetails/userMainDetails_cubit.dart';
import '../../../domain/datasources/report_remote_data_source.dart';
import '../../models/report_details/report_models.dart';

class ReportDetailsRemoteDataSourceImpl implements ReportDetailsRemoteDataSource {
  final DioClient dio;
  final userMainDetailsCubit userMainDetails;
  final token = getIt<userMainDetailsCubit>().state.token;
  ReportDetailsRemoteDataSourceImpl(this.userMainDetails, {required this.dio});

  @override
  Future<ReportResponse> getReportDetails(int reportId) async {
    try {
      final response = await dio.get(
        '/posts/reports/$reportId',
        header: {
          'Authorization': 'Bearer $token'
        },
      );
      return ReportResponse.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get report details: $e');
    }
  }
}
