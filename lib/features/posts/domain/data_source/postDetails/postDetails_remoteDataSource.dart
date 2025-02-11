// domain/repositories/postDetails/postDetails_remoteDataSource.dart

import 'package:social_media/features/filtering/data/models/post_model.dart';
import 'package:social_media/features/posts/data/model/postDetails/Comments_response.dart';
import 'package:social_media/core/shared/model/post_response.dart';
import 'package:social_media/features/posts/presentation/postDetails/presentation/logic/post_details_cubit.dart';

abstract class PostDetailsRemoteDataSource {
  Future<PostData> getPostDetails(int postId);
  Future<PostCommentsModel> getPostComments(int postId);
  Future<int?> getPostCommentsCount(int postId);
  Future<double?> getPostRateAverage(int postId);

  Future<dynamic> RatePost(int postId, int rate);
  Future<dynamic> GiveReaction(int postId, int commentId, ReactionType reactionType);

  Future<dynamic> deleteComment(int postId, int commentId);
  Future<dynamic> createComment(int postId, String comment);
}
