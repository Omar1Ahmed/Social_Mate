import 'package:json_annotation/json_annotation.dart';

part 'Comments_response.g.dart';

@JsonSerializable()
class PostCommentsModel {
  final List<Comment> data;

  PostCommentsModel({required this.data});

  factory PostCommentsModel.fromJson(Map<String, dynamic> json) => _$PostCommentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostCommentsModelToJson(this);
}

@JsonSerializable()
class Comment {
  final int id;
  final String content;
  final CreatedBy createdBy;
  final DateTime createdOn;
  final int numOfLikes;
  final int numOfDisLikes;

  Comment({
    required this.id,
    required this.content,
    required this.createdBy,
    required this.createdOn,
    required this.numOfLikes,
    required this.numOfDisLikes,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class CreatedBy {
  final int id;
  final String fullName;

  CreatedBy({
    required this.id,
    required this.fullName,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);
}
