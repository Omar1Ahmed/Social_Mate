import '../../data/models/report_details/report_models.dart';

abstract class ReportDetailsRemoteDataSource {
  Future<ReportResponse> getReportDetails(int reportId);
}