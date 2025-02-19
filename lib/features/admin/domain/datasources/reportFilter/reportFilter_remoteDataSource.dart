
import 'package:social_media/features/admin/data/models/main_report_model.dart';

abstract class ReportFilterRemoteDataSource {
  Future<MainReportModel> getReports({ required int pageOffset, required int pageSize,Map<String, dynamic>? queryParams});
}