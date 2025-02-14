import 'package:json_annotation/json_annotation.dart';
import 'package:social_media/features/admin/domain/entities/main_report_entity.dart';

import '../../../../core/helper/format_time_ago.dart';

part 'main_report_model.g.dart'; // Generated file for JsonSerializable

@JsonSerializable()
class MainReportModel {
  final List<ReportData> data;
  final int total;

  const MainReportModel({
    required this.data,
    required this.total,
  });

  factory MainReportModel.fromJson(Map<String, dynamic> json) =>
      _$MainReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainReportModelToJson(this);

  List<MainReportEntity> toReportEntities() {
    return data.map((reportData) {
      return MainReportEntity(
        reportId: reportData.id,
        postId: reportData.post.id,
        postTitle: reportData.post.title.isNotEmpty
            ? reportData.post.title
            : 'No Title',
        reportedBy: reportData.createdBy.fullName.isNotEmpty
            ? reportData.createdBy.fullName
            : 'Unknown',
        reportedOn: formatTimeAgo(reportData.createdOn),
        status: reportData.status.titleEn.isNotEmpty
            ? reportData.status.titleEn
            : 'Unknown',
        category: reportData.category.titleEn.isNotEmpty
            ? reportData.category.titleEn
            : 'Uncategorized',
        total: total,
      );
    }).toList();
  }
}

@JsonSerializable()
class ReportData {
  final int id;
  final Post post;
  final User createdBy;
  final Category category;
  final Status status;
  final String createdOn;
  final String lastModifiedOn;
  final String reason;

  const ReportData({
    required this.id,
    required this.post,
    required this.createdBy,
    required this.category,
    required this.status,
    required this.createdOn,
    required this.lastModifiedOn,
    required this.reason,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) =>
      _$ReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDataToJson(this);
}

@JsonSerializable()
class Post {
  final int id;
  final String title;
  final User createdBy;

  const Post({
    required this.id,
    required this.title,
    required this.createdBy,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class Category {
  final int id;
  final String titleEn;

  const Category({
    required this.id,
    required this.titleEn,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Status {
  final int id;
  final String titleEn;

  const Status({
    required this.id,
    required this.titleEn,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

@JsonSerializable()
class User {
  final int id;
  final String fullName;

  const User({
    required this.id,
    required this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// Extended Model for Detailed Report Information
@JsonSerializable()
class DetailedReportModel {
  final ReportDetails reportDetails;
  final List<RelatedReport> relatedReports;

  const DetailedReportModel({
    required this.reportDetails,
    required this.relatedReports,
  });

  factory DetailedReportModel.fromJson(Map<String, dynamic> json) =>
      _$DetailedReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedReportModelToJson(this);
}

@JsonSerializable()
class ReportDetails {
  final User createdBy;
  final String reason;
  final Category category;
  final Status status;
  final User lastModifiedBy;
  final String createdOn;
  final String lastModifiedOn;
  final Post post;

  const ReportDetails({
    required this.createdBy,
    required this.reason,
    required this.category,
    required this.status,
    required this.lastModifiedBy,
    required this.createdOn,
    required this.lastModifiedOn,
    required this.post,
  });

  factory ReportDetails.fromJson(Map<String, dynamic> json) =>
      _$ReportDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDetailsToJson(this);
}

@JsonSerializable()
class RelatedReport {
  final int id;
  final User createdBy;
  final Category category;
  final Status status;

  const RelatedReport({
    required this.id,
    required this.createdBy,
    required this.category,
    required this.status,
  });

  factory RelatedReport.fromJson(Map<String, dynamic> json) =>
      _$RelatedReportFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedReportToJson(this);
}
