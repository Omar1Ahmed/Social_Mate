// can't use failure class and dio handle error method together , it's nonsense

import 'package:social_media/features/filtering/could_be_shared/network_clients/dio_network_client.dart';
import 'package:social_media/features/filtering/data/models/post_model.dart';

abstract class FilteredPostsRemoteSource {
  Future<List<PostModel>> getFilteredPosts(
      {Map<String, dynamic>? queryParameters, required String token});
}

class FilteredPostsRemoteSourceImpl implements FilteredPostsRemoteSource {
  final DioNetworkClient dioNetworkClient;

  FilteredPostsRemoteSourceImpl({required this.dioNetworkClient});

  @override
  Future<List<PostModel>> getFilteredPosts({
    Map<String, dynamic>? queryParameters,
    required String token,
  }) async {
    final response = await dioNetworkClient.get(
      '/posts',
      queryParameters: queryParameters,
      token: token,
    );


    final postModel = PostModel.fromJson(response.data);
    return [postModel];
  }
}
