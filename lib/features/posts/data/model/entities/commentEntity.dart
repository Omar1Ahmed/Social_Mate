import 'package:social_media/core/shared/entities/post_entity.dart';

class CommentEntity {
  final int id;
  final String content;
  final UserEntity createdBy;
  final DateTime createdOn;
  final String FormattedDate;
  int numOfLikes;
  int numOfDisLikes;

  CommentEntity({
    required this.id,
    required this.content,
    required this.createdBy,
    required this.createdOn,
    required this.FormattedDate,
    required this.numOfLikes,
    required this.numOfDisLikes
  });
}

