import 'package:bloc/bloc.dart';
import 'package:social_media/core/helper/Connectivity/connectivity_helper.dart';
import 'package:social_media/features/admin/domain/entities/main_report_entity.dart';
import 'package:social_media/features/admin/domain/repositories/main_report_repo.dart';

part 'all_reports_state.dart';

class AllReportsCubit extends Cubit<AllReportsState> {
  final MainReportRepo mainReportRepo;
  int _pageOffset = 0;
  final int _pageSize = 5;
  bool _hasMore = true;

  AllReportsCubit({required this.mainReportRepo}) : super(AllReportsInitial());

  Future<void> getAllReports(Map<String, dynamic> queryParams,
      {required String token}) async {
    bool isConnected = await ConnectivityHelper.isConnected();
    if (!isConnected) {
      emit(AllReportsConnectionError());
      print(state);
      return;
    } else {
      if (state is AllReportsLoading) return;
      _pageOffset = 0;
      _hasMore = true;
      emit(AllReportsLoading());

      try {
        final result = await mainReportRepo.getAllReports(
          {...queryParams, 'pageOffset': _pageOffset, 'pageSize': _pageSize},
          token: token,
        );

        final statusCode = result['statusCode'] as int;
        print('all reports staus code: $statusCode');
        if (statusCode != 200) {
          emit(AllReportsStatusCodeError());
          return;
        }
        final reports = result['reports'] as List<MainReportEntity>;

        print("reports retrived: ${reports.length} items"); // Debug log
        if (reports.isEmpty) {
          emit(AllReportsEmpty(reports));
        } else {
          _hasMore = reports.length == _pageSize;
          emit(AllReportsLoaded(
            reports,
            _hasMore,
          ));
        }
      } catch (e) {
        emit(AllReportsError(e.toString()));
      }
    }
  }

  Future<void> loadMoreReports(Map<String, dynamic> queryParams,
      {required String token}) async {
    if (state is! AllReportsLoading || !_hasMore) return;

    final currentState = state as AllReportsLoaded;
    emit(currentState.copyWith(
        hasMore: false)); // Disable loading more temporarily

    try {
      _pageOffset += _pageSize;
      final result = await mainReportRepo.getAllReports(
        {
          ...queryParams,
          'pageOffset': _pageOffset,
          'pageSize': _pageSize,
        },
        token: token,
      );

      final statusCode = result['statusCode'] as int;
      print('pagination status code: $statusCode');
      if(statusCode != 200){
        emit(AllReportsStatusCodeError());
        return;
      }

      final newReports = result['reports'] as List<MainReportEntity>;

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
