// lib/data/repositories/report_repository_impl.dart


import 'package:social_media/features/admin/report_details/domain/entity/report_entity.dart';

import '../../domain/repository/report_repository.dart';
import '../data_source/report_details_remote_data_sourc_impl.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportDataSource dataSource;

  ReportRepositoryImpl({required this.dataSource});

  @override
  Future<ReportEntity> getReportDetails() async {
    final reportResponse = await dataSource.fetchReportData();
    return ReportEntity(
      reason: reportResponse.reportDetails.reason,
      categoryTitle: reportResponse.reportDetails.category.titleEn,
      statusTitle: reportResponse.reportDetails.status.titleEn,
    );
  }

  @override
  Future<List<ReportEntity>> getRelatedReports() async {
    final reportResponse = await dataSource.fetchReportData();
    return reportResponse.relatedReports.map((relatedReport) {
      return ReportEntity(
        reason: 'Related Report', // Adjust based on your JSON structure
        categoryTitle: relatedReport.category.titleEn,
        statusTitle: relatedReport.status.titleEn,
      );
    }).toList();
  }
}