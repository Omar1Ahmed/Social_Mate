// lib/data/repositories/report_repository_impl.dart

import 'package:social_media/features/admin/data/models/report_details/report_models.dart';

import '../../../domain/repositories/report_details/report_repository.dart';
import '../../datasources/report_details/report_details_remote_data_sourc_impl.dart';

class ReportDetailsRepositoryImpl implements ReportDetailsRepository {
  final ReportDetailsRemoteDataSourceImpl dataSource;

  ReportDetailsRepositoryImpl({required this.dataSource});
  
  @override
  Future<List<RelatedReport>> getRelatedReports(int reportId) {
    throw UnimplementedError();
  }
  
  @override
  Future<ReportResponse> getReportDetails(int reportId) {
    return dataSource.getReportDetails(reportId);
  }

}
