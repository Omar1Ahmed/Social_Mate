// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelatedReport _$RelatedReportFromJson(Map<String, dynamic> json) =>
    RelatedReport(
      id: (json['id'] as num).toInt(),
      createdBy: User.fromJson(json['createdBy'] as Map<String, dynamic>),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      status: Status.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RelatedReportToJson(RelatedReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy.toJson(),
      'category': instance.category.toJson(),
      'status': instance.status.toJson(),
    };

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) =>
    ReportResponse(
      reportDetails:
          ReportData.fromJson(json['reportDetails'] as Map<String, dynamic>),
      relatedReports: (json['relatedReports'] as List<dynamic>)
          .map((e) => RelatedReport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportResponseToJson(ReportResponse instance) =>
    <String, dynamic>{
      'reportDetails': instance.reportDetails.toJson(),
      'relatedReports': instance.relatedReports.map((e) => e.toJson()).toList(),
    };
