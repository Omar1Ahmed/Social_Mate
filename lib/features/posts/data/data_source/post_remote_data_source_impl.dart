import '../../../../core/helper/dotenv/dot_env_helper.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/repository/post_remote_data_source.dart';
import '../model/post_response.dart';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient dio;

  PostRemoteDataSourceImpl({required this.dio});

  final String baseUrl = EnvHelper.getString('posts_Base_url');

  @override
  Future<PostResponse> getPosts( int pageOffset, int pageSize) async {
    final response = await dio.get("$baseUrl/posts?createdBy=1", queryParameters: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzM4NCJ9.eyJST0xFU19JRFMiOlsyXSwiVVNFUl9JRCI6Niwic3ViIjoiYXNkYXNkMTIzQGdtYWlsLmNvbSIsImlhdCI6MTczODcwNjIxNSwiZXhwIjoxNzM4NzkyNjE1fQ.Jj7XhDoE86HjpItLG_rRgAx1_aczgoo4lMrsZprN4qBwHGpPMeLvEmp4L0Zh6yDd',
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
        'Authorization': 'Bearer eyJhbGciOiJIUzM4NCJ9.eyJST0xFU19JRFMiOlsyXSwiVVNFUl9JRCI6Niwic3ViIjoiYXNkYXNkMTIzQGdtYWlsLmNvbSIsImlhdCI6MTczODcwNjIxNSwiZXhwIjoxNzM4NzkyNjE1fQ.Jj7XhDoE86HjpItLG_rRgAx1_aczgoo4lMrsZprN4qBwHGpPMeLvEmp4L0Zh6yDd'
      },
    );
  }
}
