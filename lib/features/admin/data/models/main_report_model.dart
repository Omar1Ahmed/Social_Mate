import 'package:social_media/features/admin/domain/entities/main_report_entity.dart';

import '../../../../core/shared/model/post_response.dart';

class MainReportModel {
  final List<ReportData> data;
  final int total;

  const MainReportModel({
    required this.data,
    required this.total,
  });

  factory MainReportModel.fromJson(Map<String, dynamic> json) {
    return MainReportModel(
      data: (json['data'] as List<dynamic>?)?.map((item) => ReportData.fromJson(item)).toList() ?? [],
      total: json['total']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'total': total,
    };
  }

  List<MainReportEntity> toReportEntities() {
    return data.map((reportData) {
      return MainReportEntity(
        postTitle: reportData.post.title.isNotEmpty ? reportData.post.title : 'No Title',
        reportedBy: reportData.createdBy.fullName.isNotEmpty ? reportData.createdBy.fullName : 'Unknown',
        reportedOn: reportData.createdOn.isNotEmpty ? reportData.createdOn : 'N/A',
        status: reportData.status.titleEn.isNotEmpty ? reportData.status.titleEn : 'Unknown',
        category: reportData.category.titleEn.isNotEmpty ? reportData.category.titleEn : 'Uncategorized',
        total: total, // Use the total field from MainReportModel
      );
    }).toList();
  }
}

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
    required this.reason,
    required this.id,
    required this.post,
    required this.createdBy,
    required this.category,
    required this.status,
    required this.createdOn,
    required this.lastModifiedOn,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      id: json['id']?.toInt() ?? 0,
      post: Post.fromJson(json['post'] ?? {}),
      createdBy: User.fromJson(json['createdBy'] ?? {}),
      category: Category.fromJson(json['category'] ?? {}),
      status: Status.fromJson(json['status'] ?? {}),
      createdOn: json['createdOn']?.toString() ?? '',
      lastModifiedOn: json['lastModifiedOn']?.toString() ?? '',
      reason: json['reason'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post': post.toJson(),
      'createdBy': createdBy.toJson(),
      'category': category.toJson(),
      'status': status.toJson(),
      'createdOn': createdOn,
      'lastModifiedOn': lastModifiedOn,
      'reason': reason
    };
  }
}

class Post {
  final int id;
  final String title;
  final User createdBy; 

  const Post({
    required this.id,
    required this.title,
    required this.createdBy,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id']?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      createdBy: User.fromJson(json['createdBy'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdBy': createdBy.toJson(),
    };
  }
}

class Category {
  final int id;
  final String titleEn;

  const Category({
    required this.id,
    required this.titleEn,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id']?.toInt() ?? 0,
      titleEn: json['titleEn']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titleEn': titleEn,
    };
  }
}

class Status {
  final int id;
  final String titleEn;

  const Status({
    required this.id,
    required this.titleEn,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id']?.toInt() ?? 0,
      titleEn: json['titleEn']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titleEn': titleEn,
    };
  }
}
