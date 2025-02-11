// lib/domain/repositories/report_repository.dart

import '../../entities/report_details/report_entity.dart';

abstract class ReportRepository {
  Future<ReportEntity> getReportDetails();
  Future<List<ReportEntity>> getRelatedReports();
}