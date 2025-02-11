import 'package:social_media/features/admin/all_reports/domain/entities/main_report_entity.dart';

abstract class MainReportRepo {
  Future<List<MainReportEntity>> getAllReports(Map<String, dynamic> queryParams,
      {required String token});
}