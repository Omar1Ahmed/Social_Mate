import 'package:bloc/bloc.dart';
import 'package:social_media/features/admin/all_reports/domain/entities/main_report_entity.dart';
import 'package:social_media/features/admin/all_reports/domain/repositories/main_report_repo.dart';


part 'all_reports_state.dart';

class AllReportsCubit extends Cubit<AllReportsState> {
  final MainReportRepo mainReportRepo;
  AllReportsCubit(this.mainReportRepo) : super(AllReportsInitial());

  Future<void> getAllReports(Map<String, dynamic> queryParams, {required String token}) async {
    
  }
}
