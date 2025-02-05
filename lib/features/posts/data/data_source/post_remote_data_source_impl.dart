import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_state.dart';

import '../../../../core/helper/dotenv/dot_env_helper.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/repository/post_remote_data_source.dart';
import '../model/post_response.dart';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient dio;
  final userMainDetailsCubit userMainDetails; // Inject the Cubit

  PostRemoteDataSourceImpl({required this.dio,
    required this.userMainDetails, // Dependency injection
  });

  final String baseUrl = EnvHelper.getString('posts_Base_url');

  @override
  Future<PostResponse> getPosts( int pageOffset, int pageSize) async {
    final response = await dio.get("$baseUrl/posts?createdBy=1", queryParameters: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userMainDetails.state.token}',
      'pageOffset': pageOffset,
      'pageSize': pageSize
    });
    return PostResponse.fromJson(response);
  }

  @override
  Future<void> createPost(CreatePostData post) async {
    final postData = post.toJson();
    await dio.post(
      "$baseUrl/posts",
      postData,
      queryParameters: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userMainDetails.state.token}'
      },
    );
  }
}
