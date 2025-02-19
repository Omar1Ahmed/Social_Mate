import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/features/admin/domain/entities/main_report_entity.dart';
import 'package:social_media/features/admin/domain/repositories/main_report_repo.dart';
import 'package:social_media/features/admin/domain/repositories/reportFilter/reportFilter_repo.dart';

part 'report_filter_state.dart';

class ReportFilterCubit extends Cubit<ReportFilterState> {
  final reportFilterRepository ReportRepo;
  final userMainDetailsCubit userMainDetails;

  ReportFilterCubit({required this.userMainDetails, required this.ReportRepo}) : super(ReportFilterInitial());


  List<MainReportEntity>? reports;
  int _currentPage = 0;
  int _pageSize = 3;
  bool hasMoreComments = true;
  bool isLoading = false;

  Future<void> getReports({int? pageOffset = null, int? pageSize = null }) async {
    print('get reports');

    if (!hasMoreComments || isLoading) return;

    isLoading = true;
    int total =0;

    try {
      emit(ReportFilterloading());
      final (newReports, total) = await ReportRepo.getReports(
          pageSize: _pageSize,
          pageOffset: _currentPage,
      //     queryParams: {
      //   'pageOffset': pageOffset ?? _currentPage,
      //   'pageSize': pageSize ?? _pageSize
      // },

      );

      print('has more comments ${(_currentPage * _pageSize) < total}');
      print('has more comments ${total}');
      print('has more comments ${_currentPage }');


      // print('comments length ${comments!.length} $_currentPage $commentsCount ${newReports.length}');

      if(newReports.isEmpty) {
        hasMoreComments = false;
        reports ??= [];
      }else{
        reports ??= [];
        reports!.addAll(newReports);

        _currentPage++;
        print('has more comments ${(_currentPage * _pageSize) < total}');
        hasMoreComments = (_currentPage * _pageSize) < total;
      }

      emit(ReportFilterloaded());
    } catch (e, trace) {
      print('rate Error ${e.toString()}');
      print(trace);
      emit(ReportFilterError(e.toString()));
    }finally{
      isLoading = false;
    }
  }
}
