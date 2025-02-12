// lib/domain/repositories/report_repository.dart

import '../../../data/models/main_report_model.dart';

abstract class ReportDetailsRepository {
  Future<ReportData> getReportDetails(int reportId);
  Future<List<ReportData>> getRelatedReports(int reportId);
}