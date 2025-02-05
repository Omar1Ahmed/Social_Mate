// domain/repositories/post_remote_data_source.dart
import '../../data/model/post_response.dart';

abstract class PostRemoteDataSource {
  Future<PostResponse> getPosts(int pageOffset, int pageSize);
  Future<void> createPost(CreatePostData post);
}