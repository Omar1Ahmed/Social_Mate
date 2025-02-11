// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: (json['id'] as num).toInt(),
      titleEn: json['titleEn'] as String,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'titleEn': instance.titleEn,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      id: (json['id'] as num).toInt(),
      titleEn: json['titleEn'] as String,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'id': instance.id,
      'titleEn': instance.titleEn,
    };

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      createdBy: User.fromJson(json['createdBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdBy': instance.createdBy.toJson(),
    };

ReportDetail _$ReportDetailFromJson(Map<String, dynamic> json) => ReportDetail(
      createdBy: User.fromJson(json['createdBy'] as Map<String, dynamic>),
      reason: json['reason'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      status: Status.fromJson(json['status'] as Map<String, dynamic>),
      lastModifiedBy:
          User.fromJson(json['lastModifiedBy'] as Map<String, dynamic>),
      createdOn: json['createdOn'] as String,
      lastModifiedOn: json['lastModifiedOn'] as String,
      post: Post.fromJson(json['post'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportDetailToJson(ReportDetail instance) =>
    <String, dynamic>{
      'createdBy': instance.createdBy.toJson(),
      'reason': instance.reason,
      'category': instance.category.toJson(),
      'status': instance.status.toJson(),
      'lastModifiedBy': instance.lastModifiedBy.toJson(),
      'createdOn': instance.createdOn,
      'lastModifiedOn': instance.lastModifiedOn,
      'post': instance.post.toJson(),
    };

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
          ReportDetail.fromJson(json['reportDetails'] as Map<String, dynamic>),
      relatedReports: (json['relatedReports'] as List<dynamic>)
          .map((e) => RelatedReport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportResponseToJson(ReportResponse instance) =>
    <String, dynamic>{
      'reportDetails': instance.reportDetails.toJson(),
      'relatedReports': instance.relatedReports.map((e) => e.toJson()).toList(),
    };
