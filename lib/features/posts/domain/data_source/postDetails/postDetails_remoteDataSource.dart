// domain/repositories/postDetails/postDetails_remoteDataSource.dart

import 'package:social_media/features/posts/data/model/postDetails/postDetails_reponse.dart';

abstract class PostDetailsRemoteDataSource {
  Future<PostDetailsModel> getPostDetails(int postId);
  Future<PostDetailsModel> getPostComments(int postId);
}
