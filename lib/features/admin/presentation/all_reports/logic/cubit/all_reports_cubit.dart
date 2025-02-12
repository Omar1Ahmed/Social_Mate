import 'package:bloc/bloc.dart';
import 'package:social_media/features/admin/domain/entities/main_report_entity.dart';
import 'package:social_media/features/admin/domain/repositories/main_report_repo.dart';

part 'all_reports_state.dart';

class AllReportsCubit extends Cubit<AllReportsState> {
  final MainReportRepo mainReportRepo;
  int _pageOffset = 0;
  final int _pageSize = 5;
  bool _hasMore = true;

  AllReportsCubit(this.mainReportRepo) : super(AllReportsInitial());

  Future<void> getAllReports(Map<String, dynamic> queryParams,
      {required String token}) async {
    if (state is AllReportsLoading) return;
    _pageOffset = 0;
    _hasMore = true;
    emit(AllReportsLoading());

    try {
      final allReports = await mainReportRepo.getAllReports(
        {...queryParams, 'pageOffset': _pageOffset, 'pageSize': _pageSize},
        token: token,
      );

      print("reports retrived: ${allReports.length} items"); // Debug log
      if (allReports.isEmpty) {
        emit(AllReportsEmpty(allReports));
      } else {
        _hasMore = allReports.length == _pageSize;
        emit(AllReportsLoaded(
          allReports,
          _hasMore,
        ));
      }
    } catch (e) {
      emit(AllReportsError(e.toString()));
    }
  }

  Future<void> loadMoreReports(Map<String, dynamic> queryParams,
      {required String token}) async {
    //final bool isConnected = await ConnectivityHelper.isConnected();
    // if (isConnected) {
    //   emit(FilteredPostsNetworkError());
    //   return;
    // }
    if (state is! AllReportsLoading || !_hasMore) return;

    final currentState = state as AllReportsLoaded;
    emit(currentState.copyWith(
        hasMore: false)); // Disable loading more temporarily

    try {
      _pageOffset += _pageSize;
      final newReports = await mainReportRepo.getAllReports(
        {
          ...queryParams,
          'pageOffset': _pageOffset,
          'pageSize': _pageSize,
        },
        token: token,
      );

      _hasMore = newReports.length == _pageSize;
      final updatedPosts = [...currentState.allReports, ...newReports];
      emit(currentState.copyWith(
        allReports: updatedPosts,
        hasMore: _hasMore,
      ));
    } catch (e) {
      emit(AllReportsError(e.toString()));
    }
  }
}
