import 'package:social_media/features/admin/data/datasources/all_reports_remote_source.dart';
import 'package:social_media/features/admin/data/models/main_report_model.dart';
import 'package:social_media/features/admin/domain/repositories/main_report_repo.dart';

class MainReportRepoImpl implements MainReportRepo {
  final AllReportsRemoteSource allReportsRemoteSource;
  MainReportRepoImpl({required this.allReportsRemoteSource});
  @override
  @override
Future<Map<String, dynamic>> getAllReports(Map<String, dynamic> queryParams,
    {required String token}) async {
  try {
    final result =
        await allReportsRemoteSource.getAllReports(queryParams, token: token);

    final reportModels = result['reports'] as List<MainReportModel>;
    final statusCode = result['statusCode'] as int;

    final reportEntities =
        reportModels.expand((model) => model.toReportEntities()).toList();

    // Return both status code and entities
    return {
      'statusCode': statusCode,
      'reports': reportEntities,
    };
  } catch (e) {
    throw Exception('Failed to fetch reports in repo: $e');
  }
}

}
