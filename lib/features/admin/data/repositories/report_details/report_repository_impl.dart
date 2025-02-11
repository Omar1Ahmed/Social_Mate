// lib/data/repositories/report_repository_impl.dart

import 'package:social_media/features/admin/data/models/report_details/report_models.dart';

import '../../../domain/repositories/report_details/report_repository.dart';
import '../../datasources/report_details/report_details_remote_data_sourc_impl.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportDataSource dataSource;

  ReportRepositoryImpl({required this.dataSource});

  @override
  Future<ReportResponse> getReportDetails() async {
    final reportResponse = await dataSource.fetchReportData();
    return reportResponse;
  }

  @override
  Future<List<RelatedReport>> getRelatedReports() async{
    return dataSource.fetchReportData().then((value) => value.relatedReports);
  }
}
