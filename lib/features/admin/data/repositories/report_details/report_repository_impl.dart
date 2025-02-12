// lib/data/repositories/report_repository_impl.dart


import '../../../domain/repositories/report_details/report_repository.dart';
import '../../datasources/report_details/report_details_remote_data_sourc_impl.dart';
import '../../models/main_report_model.dart';

class ReportDetailsRepositoryImpl implements ReportDetailsRepository {
  final ReportDetailsRemoteDataSourceImpl dataSource;

  ReportDetailsRepositoryImpl({required this.dataSource});
  
  @override
  Future<List<ReportData>> getRelatedReports(int reportId) {
    throw UnimplementedError();
  }
  
  @override
  Future<ReportData> getReportDetails(int reportId) {
    return dataSource.getReportDetails(reportId);
  }

}
