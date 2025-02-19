
import 'package:social_media/features/admin/domain/entities/main_report_entity.dart';

abstract class reportFilterRepository {
  Future<
      (List<MainReportEntity>,
      int)
      > getReports({ required int pageOffset, required int pageSize,Map <String,dynamic>? queryParams});
}