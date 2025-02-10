// domain/repositories/postDetails/postDetails_remoteDataSource.dart

import 'package:social_media/features/filtering/data/models/post_model.dart';
import 'package:social_media/features/posts/data/model/post_response.dart';

abstract class PostDetailsRemoteDataSource {
  Future<PostData> getPostDetails(int postId);
  Future<void> getPostComments(int postId);
}
