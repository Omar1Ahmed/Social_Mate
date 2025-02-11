part of 'report_details_cubit.dart';

sealed class ReportDetailsState extends Equatable {
  const ReportDetailsState();

  @override
  List<Object> get props => [];
}

final class ReportDetailsInitial extends ReportDetailsState {}
final class ReportDetailsLoading extends ReportDetailsState {}
final class ReportDetailsError extends ReportDetailsState {
  final String message;
  const ReportDetailsError({required this.message});

}
final class ReportDetailsLoaded extends ReportDetailsState {
  final ReportResponse report;
  const ReportDetailsLoaded({required this.report});
}
