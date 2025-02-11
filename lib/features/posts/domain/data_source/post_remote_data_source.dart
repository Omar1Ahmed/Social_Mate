// domain/repositories/post_remote_data_source.dart

import '../../../../core/shared/model/create_report_model.dart';
import '../../../../core/shared/model/post_response.dart';

abstract class PostRemoteDataSource {
  Future<PostResponse> getPosts(int pageOffset, int pageSize);
  Future<void> createPost(CreatePostData post);
  Future<void> deletePost(int postId);
  Future<void> reportPost(int postId ,CreateReportModel createReportModel);
}
