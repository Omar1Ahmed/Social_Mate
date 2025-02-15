
import 'package:social_media/features/admin/data/models/main_report_model.dart';

abstract class ReportDetailsRemoteDataSource {
  Future<DetailedReportModel> getReportDetails(int reportId);
  Future<List<ReportData>> getRelatedReports(int reportId);
  Future<double> getAvgRate(int reportId);
  Future<int> getCommentsCount(int reportId);
}