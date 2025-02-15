// lib/domain/repositories/report_repository.dart

import '../../../data/models/main_report_model.dart';

abstract class ReportDetailsRepository {
  Future<DetailedReportModel> getReportDetails(int reportId);
  Future<List<ReportData>> getRelatedReports(int reportId);
  Future<double> getAvgRate(int reportId);
  Future<int> getCommentsCount(int reportId);
}