// lib/data/datasources/report_data_source.dart

import 'package:social_media/core/network/dio_client.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/userMainDetails/userMainDetails_cubit.dart';
import '../../../domain/datasources/report_remote_data_source.dart';
import '../../models/main_report_model.dart';

class ReportDetailsRemoteDataSourceImpl implements ReportDetailsRemoteDataSource {
  final DioClient reportDio;
  final DioClient postsDio;

  final userMainDetailsCubit userMainDetails;
  final token = getIt<userMainDetailsCubit>().state.token;
  ReportDetailsRemoteDataSourceImpl(this.userMainDetails, {required this.postsDio, required this.reportDio});

  @override
  Future<DetailedReportModel> getReportDetails(int reportId) async {
    final response = await reportDio.get(
      '/posts/reports/$reportId',
      header: {
        'Authorization': 'Bearer $token'
      },
    );
    return DetailedReportModel.fromJson(response);
  }

  @override
  Future<double> getAvgRate(int postId) async {
    final response = await postsDio.get(
      '/posts/$postId/rates/average',
      header: {
        'Authorization': 'Bearer $token'
      },
    );
    print("avg rate $response");
    return response['data'];
  }

  @override
  Future<int> getCommentsCount(int postId) async {
    final response = await postsDio.get(
      '/posts/$postId/comments/count',
      header: {
        'Authorization': 'Bearer $token'
      },
    );
    print("comments count $response");
    return response['data'];
    
  }

  @override
  Future<List<ReportData>> getRelatedReports(int reportId) {
    throw UnimplementedError();
  }
}
