import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/SharedPref/SharedPrefKeys.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';

import '../../../../core/helper/dotenv/dot_env_helper.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/repository/post_remote_data_source.dart';
import '../model/post_response.dart';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient dio;
  final userMainDetailsCubit userMainDetails;

  PostRemoteDataSourceImpl({
    required this.dio,
    required this.userMainDetails,
  });

  final String baseUrl = EnvHelper.getString('posts_Base_url');

  @override
  Future<PostResponse> getPosts(int pageOffset, int pageSize) async {
    // 2 lines by marwan

    final token = getIt<userMainDetailsCubit>().state.token;

    try {
      final response = await dio.get("$baseUrl/posts?pageOffset=$pageOffset&pageSize=$pageSize", header: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userMainDetails.state.token ?? token}',
      });

      return PostResponse.fromJson(response);
    } catch (e) {
      throw Exception("Error fetching posts: ${e.toString()}");
    }
  }

  @override
  Future<void> createPost(CreatePostData post) async {
    final SharedPrefHelper _sharedPrefHelper = getIt<SharedPrefHelper>();
    final token = _sharedPrefHelper.getString(SharedPrefKeys.tokenKey);
    final postData = post.toJson();
    try {
      await dio.post(
        "$baseUrl/posts",
        postData,
        header: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userMainDetails.state.token ?? token}',
        },
      );
    } catch (e) {
      throw Exception("Error creating post: ${e.toString()}");
    }
  }

  @override
  Future<void> deletePost(int postId) async {
    final SharedPrefHelper _sharedPrefHelper = getIt<SharedPrefHelper>();
    final token = _sharedPrefHelper.getString(SharedPrefKeys.tokenKey);
    await dio.delete(
      "$baseUrl/posts/$postId",
      header: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userMainDetails.state.token ?? token}',
      },
    );
  }
}
