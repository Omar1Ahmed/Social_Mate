// domain/repositories/post_repository.dart

import '../../../../core/entities/post_entity.dart';
import '../../data/model/post_response.dart';

abstract class PostRepository {
  Future<(List<PostEntity>, int)> getPosts(int pageOffset, int pageSize);
  Future<PostEntity> createPost(CreatePostData post); 
  Future<void> deletePost(int postId);
}