import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/shared/model/post_response.dart';
import '../main_report_model.dart';

part 'report_models.g.dart';

// RelatedReport model
@JsonSerializable(explicitToJson: true)
class RelatedReport {
  final int id;
  final User createdBy;
  final Category category;
  final Status status;

  RelatedReport({
    required this.id,
    required this.createdBy,
    required this.category,
    required this.status,
  });

  factory RelatedReport.fromJson(Map<String, dynamic> json) => _$RelatedReportFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedReportToJson(this);
}

// ReportResponse model
@JsonSerializable(explicitToJson: true)
class ReportResponse {
  final ReportData reportDetails;
  final List<RelatedReport> relatedReports;

  ReportResponse({
    required this.reportDetails,
    required this.relatedReports,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) => _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}
