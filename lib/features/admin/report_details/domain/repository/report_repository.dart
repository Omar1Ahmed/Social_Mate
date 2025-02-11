// lib/domain/repositories/report_repository.dart

import '../entity/report_entity.dart';

abstract class ReportRepository {
  Future<ReportEntity> getReportDetails();
  Future<List<ReportEntity>> getRelatedReports();
}