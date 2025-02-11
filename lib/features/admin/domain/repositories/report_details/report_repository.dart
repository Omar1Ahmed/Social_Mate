// lib/domain/repositories/report_repository.dart

import '../../../data/models/report_details/report_models.dart';

abstract class ReportDetailsRepository {
  Future<ReportResponse> getReportDetails(int reportId);
  Future<List<RelatedReport>> getRelatedReports(int reportId);
}