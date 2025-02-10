import 'package:social_media/core/network/dio_client.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/features/posts/data/model/post_response.dart';
import 'package:social_media/features/posts/domain/data_source/postDetails/postDetails_remoteDataSource.dart';

class PostDetailsRemoteDataSourceImpl implements PostDetailsRemoteDataSource {
  final DioClient dio;
  final userMainDetailsCubit userMainDetails;

  PostDetailsRemoteDataSourceImpl({required this.dio, required this.userMainDetails});

  @override
  Future<PostData> getPostDetails(int postId) async {

    try {
      final response = await dio.get("/posts/$postId", header: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${userMainDetails.state.token}',
      },);

      print(response);
      print('base Url : ${dio.baseUrl}');
      print('base Url : ${dio.dio.options.baseUrl}');
      return PostData.fromJson(response);
    } catch (e) {

      throw Exception("Error fetching posts: ${e.toString()}");

    }


  }

  @override
  Future<void> getPostComments(int postId) {
    // TODO: implement getPostComments
    throw UnimplementedError();
  }

}