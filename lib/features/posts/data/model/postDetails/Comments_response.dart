import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media/core/shared/entities/post_entity.dart';
import 'package:social_media/features/posts/data/model/entities/commentEntity.dart';
import 'package:social_media/core/shared/model/post_response.dart';

part 'Comments_response.g.dart';

@JsonSerializable()
class PostCommentsModel {
  final List<Comment> data;

  PostCommentsModel({required this.data});

  factory PostCommentsModel.fromJson(Map<String, dynamic> json) => _$PostCommentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostCommentsModelToJson(this);

  toEntities() => data.map((e) => e.toEntity()).toList();
}

@JsonSerializable()
class Comment {
  final int id;
  final String content;
  final User createdBy;
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

  CommentEntity toEntity() {
    String FormattedDate = DateFormat("yyyy-MM-dd h:mm a").format(createdOn);

    return CommentEntity(
        id: id,
        content: content,
        createdBy: createdBy.toEntity(),
        createdOn: createdOn,
        FormattedDate: FormattedDate,
        numOfLikes: numOfLikes,
        numOfDisLikes: numOfDisLikes
    );
  }
}


