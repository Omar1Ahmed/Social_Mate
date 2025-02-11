// domain/repositories/post_repository.dart

import 'package:social_media/core/shared/entities/post_entity.dart';
import 'package:social_media/features/posts/data/model/entities/commentEntity.dart';
import 'package:social_media/features/posts/presentation/postDetails/presentation/logic/post_details_cubit.dart';

abstract class PostDetailsRepository {
   Future<PostEntity> getPostDetails(int postId);
   Future<List<CommentEntity>> getPostComments(int postId);
   Future<int?> getPostCommentsCount(int postId);
   Future<double?> getPostRateAverage(int postId);

   Future<dynamic> RatePost(int postId, int rate);
   Future<dynamic> GiveReaction(int postId, int commentId, ReactionType reactionType);

   Future<dynamic> deleteComment(int postId, int commentId);
   Future<dynamic> createComment(int postId,String comment);
}