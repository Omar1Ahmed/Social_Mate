// can't use failure class and dio handle error method together , it's nonsense

import 'package:dio/dio.dart';
import 'package:social_media/features/filtering/could_be_shared/fake_end_points/fake_end_points.dart';
import 'package:social_media/features/filtering/could_be_shared/network_clients/dio_network_client.dart';
import 'package:social_media/features/filtering/data/models/post_model.dart';

abstract class FilteredPostsRemoteSource {
  Future<List<PostModel>> getFilteredPosts({Map<String, dynamic>? queryParameters});
}

class FilteredPostsRemoteSourceImpl implements FilteredPostsRemoteSource {
  final DioNetworkClient dioNetworkClient;

  FilteredPostsRemoteSourceImpl({required this.dioNetworkClient});
  @override
  Future<List<PostModel>> getFilteredPosts(
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dioNetworkClient.get(FakeEndPoints.filteredPosts,
          queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final List<PostModel> posts = (response.data['data'] as List)
            .map((item) => PostModel.fromJson(item))
            .toList();
        return posts;
      }else {
        // If the status code is not 200, throw an exception
        throw Exception('Failed to fetch filtered posts. Status Code: ${response.statusCode}');
      }
    }on DioException catch (e) {
      dioNetworkClient.handleError(e);
      rethrow;
    }
  }
}
