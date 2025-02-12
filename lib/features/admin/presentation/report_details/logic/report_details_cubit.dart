import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/main_report_model.dart';
import '../../../domain/repositories/report_details/report_repository.dart';

part 'report_details_state.dart';

class ReportDetailsCubit extends Cubit<ReportDetailsState> {
  final ReportDetailsRepository _repository;
  ReportDetailsCubit(this._repository) : super(ReportDetailsInitial());
  Future<void> getReportDetails(int reportId) async {
    emit(ReportDetailsLoading());
    try {
      final report = await _repository.getReportDetails(reportId);
      emit(ReportDetailsLoaded(report: report));
    } catch (e) {
      emit(ReportDetailsError(message: e.toString()));
    }
  }
}
