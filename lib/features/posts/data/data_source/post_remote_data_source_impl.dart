import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';

import '../../../../core/helper/dotenv/dot_env_helper.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/repository/post_remote_data_source.dart';
import '../model/post_response.dart';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient dio;
  final userMainDetailsCubit userMainDetails; // Inject the Cubit

  PostRemoteDataSourceImpl({
    required this.dio,
    required this.userMainDetails, // Dependency injection
  });

  final String baseUrl = EnvHelper.getString('posts_Base_url');

  @override
  Future<PostResponse> getPosts(int pageOffset, int pageSize) async {
    try {
      final response = await dio.get("$baseUrl/posts?pageOffset=$pageOffset&pageSize=$pageSize", header: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userMainDetails.state.token}',
      });

      return PostResponse.fromJson(response);
    } catch (e) {
      throw Exception("Error fetching posts: ${e.toString()}");
    }
  }

  @override
  Future<void> createPost(CreatePostData post) async {
    final postData = post.toJson();
    try {
      await dio.post(
        "$baseUrl/posts",
        postData,
      );
    } catch (e) {
      throw Exception("Error creating post: ${e.toString()}");
    }
  }
}
