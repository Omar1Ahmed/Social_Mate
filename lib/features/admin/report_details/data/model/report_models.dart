import 'package:json_annotation/json_annotation.dart';

part 'report_models.g.dart';

// User model
@JsonSerializable()
class User {
  final int id;
  final String fullName;

  User({required this.id, required this.fullName});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// Category model
@JsonSerializable()
class Category {
  final int id;
  final String titleEn;

  Category({required this.id, required this.titleEn});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

// Status model
@JsonSerializable()
class Status {
  final int id;
  final String titleEn;

  Status({required this.id, required this.titleEn});

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

// Post model
@JsonSerializable(explicitToJson: true)
class Post {
  final int id;
  final String title;
  final User createdBy;

  Post({required this.id, required this.title, required this.createdBy});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

// ReportDetail model
@JsonSerializable(explicitToJson: true)
class ReportDetail {
  final User createdBy;
  final String reason;
  final Category category;
  final Status status;
  final User lastModifiedBy;
  final String createdOn;
  final String lastModifiedOn;
  final Post post;

  ReportDetail({
    required this.createdBy,
    required this.reason,
    required this.category,
    required this.status,
    required this.lastModifiedBy,
    required this.createdOn,
    required this.lastModifiedOn,
    required this.post,
  });

  factory ReportDetail.fromJson(Map<String, dynamic> json) => _$ReportDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDetailToJson(this);
}

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
  final ReportDetail reportDetails;
  final List<RelatedReport> relatedReports;

  ReportResponse({
    required this.reportDetails,
    required this.relatedReports,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) => _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}