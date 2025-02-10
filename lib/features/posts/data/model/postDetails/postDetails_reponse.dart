// To parse this JSON data, do
//
//     final postDetailsModel = postDetailsModelFromJson(jsonString);

import 'dart:convert';

PostDetailsModel postDetailsModelFromJson(String str) => PostDetailsModel.fromJson(json.decode(str));

String postDetailsModelToJson(PostDetailsModel data) => json.encode(data.toJson());

class PostDetailsModel {
  int? id;
  String? title;
  String? content;
  CreatedBy? createdBy;
  DateTime? createdOn;

  PostDetailsModel({
    this.id,
    this.title,
    this.content,
    this.createdBy,
    this.createdOn,
  });

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) => PostDetailsModel(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    createdBy: json["createdBy"] == null ? null : CreatedBy.fromJson(json["createdBy"]),
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "createdBy": createdBy?.toJson(),
    "createdOn": createdOn?.toIso8601String(),
  };
}

class CreatedBy {
  int? id;
  String? fullName;

  CreatedBy({
    this.id,
    this.fullName,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
  };
}
