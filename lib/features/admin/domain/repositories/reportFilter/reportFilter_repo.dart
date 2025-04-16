
import 'package:social_media/features/admin/domain/entities/main_report_entity.dart';

abstract class reportFilterRepository {
  Future<
      (List<MainReportEntity>,
      int)
      > getReports({Map <String,dynamic>? queryParams});
}