// lib/domain/repositories/report_repository.dart

import '../../../data/models/report_details/report_models.dart';

abstract class ReportRepository {
  Future<ReportResponse> getReportDetails();
  Future<List<RelatedReport>> getRelatedReports();
}