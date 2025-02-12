
import 'package:social_media/features/admin/data/models/main_report_model.dart';

abstract class ReportDetailsRemoteDataSource {
  Future<ReportData> getReportDetails(int reportId);
}