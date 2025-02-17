import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/main_report_model.dart';
import '../../../domain/repositories/report_details/report_repository.dart';
part 'report_details_state.dart';

class ReportDetailsCubit extends Cubit<ReportDetailsState> {
  final ReportDetailsRepository _repository;
  static int _reportId = 0;
  static int _postId = 0;

  // Fields to store comments count and average rating
  int? commentsCount;
  double? rateAverage;

  ReportDetailsCubit(this._repository) : super(ReportDetailsInitial());

  // Getter for commentsCount
  int? get getComCount => commentsCount;

  // Getter for rateAverage
  double? get getRateAverage => rateAverage;

  // Method to set the selected report ID
  static void setSelectedReport(int reportId) {
    _reportId = reportId;
  }

  // Method to set the selected post ID
  static void setSelectedPost(int postId) {
    _postId = postId;
  }

  Future<void> getReportDetails() async {
    if (isClosed) return;

    emit(ReportDetailsLoading());

    try {
      final report = await _repository.getReportDetails(_reportId);
      if (!isClosed) {
        setSelectedPost(report.reportDetails.post.id);

        // // Fetch comments count and average rating
        // final commentsCount = await _repository.getCommentsCount(_postId);
        // final avrageRating = await _repository.getAvgRate(_postId);

        emit(ReportDetailsLoaded(
          report: report,
          commentsCount: 0,
          avrageRating: 0,
        ));
      } else {
        emit(ReportDetailsError(message: 'No data available'));
      }
    } catch (e, trace) {
      if (!isClosed) {
        print("Error fetching report details: $e\nTrace: $trace");
        emit(ReportDetailsError(message: e.toString()));
      }
    }
  }

  Future addActionToReport(String action, String rejectReason) async {
    if (isClosed) return;
    emit(AddActionToReportLoading());
    try {
      await _repository.addActionToReport(_reportId, action, rejectReason);
      if (!isClosed) {
        emit(AddActionToReportSuccess());
        await getReportDetails();
      }
    } catch (e, trace) {
      if (!isClosed) {
        print("state error Trace : $trace");
        emit(AddActionToReportError(message: e.toString()));
      }
    }
  }
}
