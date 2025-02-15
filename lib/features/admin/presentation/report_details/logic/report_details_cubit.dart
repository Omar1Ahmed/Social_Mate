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
    if (isClosed) return; // Exit if the cubit is already closed
    emit(ReportDetailsLoading());
    try {
      final report = await _repository.getReportDetails(_reportId);
      if (!isClosed) {
        // Check again before emitting
        setSelectedPost(report.reportDetails.post.id);
        emit(ReportDetailsLoaded(report: report));
      }
    } catch (e, trace) {
      if (!isClosed) {
        // Check again before emitting
        print("state error Trace : $trace");
        emit(ReportDetailsError(message: e.toString()));
      }
    }
  }

  Future<void> getCommentsCount() async {
    if (isClosed) return; // Exit if the cubit is already closed
    emit(CommentsCountRepLoading());
    try {
      final commentsCount = await _repository.getCommentsCount(_postId);
      if (!isClosed) {
        this.commentsCount = commentsCount;
        print("data in cubit : $commentsCount");
        emit(CommentsCountLoaded(commentsCount: commentsCount));
      }
    } catch (e, trace) {
      if (!isClosed) {
        // Check again before emitting
        print("state error Trace : $trace");
        emit(ReportDetailsError(message: e.toString()));
      }
    }
  }

  Future<void> getAvrageRating() async {
    if (isClosed) return; // Exit if the cubit is already closed
    emit(GetAvrageRatingLoading());
    try {
      final avrageRating = await _repository.getAvgRate(_postId);
      if (!isClosed) {
        this.rateAverage = avrageRating;
        emit(GetAvrageRatingLoaded(avrageRating: avrageRating));
      }
    } catch (e, trace) {
      if (!isClosed) {
        print("state error Trace : $trace");
        emit(ReportDetailsError(message: e.toString()));
      }
    }
  }
}
