part of 'all_reports_cubit.dart';

abstract class AllReportsState {
}

class AllReportsInitial extends AllReportsState {}

class AllReportsLoading extends AllReportsState {}
class AllReportsLoaded extends AllReportsState {
  final List<MainReportEntity> allReports;
  final bool hasMore;
  AllReportsLoaded(this.allReports, this.hasMore);
}

class AllReportsError extends AllReportsState {
  final String errorMessage;
  AllReportsError(this.errorMessage);
}

class AllReportsConnectionError extends AllReportsState {}