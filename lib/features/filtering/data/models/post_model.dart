// 505 default value indicates an error
// Note that all default values are with the factory from json cause it is the retrived from api

import 'package:social_media/features/filtering/domain/entities/post_entity.dart';

class PostModel {
  final List<PostItem> data;
  final int total;

  PostModel({required this.data, required this.total});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    print("Raw JSON Response: $json"); // Debugging
    final data = json['data'];
    print(
        "Raw Data Field: $data"); // Check if 'data' is present and in correct format
    return PostModel(
      data: (json['data'] as List?)
              ?.map((item) => PostItem.fromJson(item))
              .toList() ??
          [],
      total: json['total'] ?? 505,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'total': total,
    };
  }
}

class PostItem {
  final int id;
  final String title;
  final String content;
  final CreatedByModel createdBy;
  final String createdOn;

  PostItem({
    required this.id,
    required this.title,
    required this.content,
    required this.createdBy,
    required this.createdOn,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return PostItem(
      id: json['id'] ?? 505,
      title: json['title'] ?? '505',
      content: json['content'] ?? '505',
      createdBy: CreatedByModel.fromJson(json['createdBy'] ?? {}),
      createdOn: json['createdOn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdBy': createdBy.toJson(),
      'createdOn': createdOn,
    };
  }

  PostEntity toEntity() {
    print("Converting PostItem ID $id to PostEntity");
    return PostEntity(
      id: id,
      title: title,
      content: content,
      createdBy: createdBy.toEntity(), // ✅ Ensure this is not null
      createdOn: createdOn,
    );
  }
}

class CreatedByModel {
  final int id;
  final String fullName;

  CreatedByModel({required this.id, required this.fullName});

  factory CreatedByModel.fromJson(Map<String, dynamic> json) {
    return CreatedByModel(
      id: json['id'] ?? 505,
      fullName: json['fullName'] ?? '505',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
    };
  }

  CreatedBy toEntity() {
    return CreatedBy(
      id: id,
      fullName: fullName,
    );
  }
}
