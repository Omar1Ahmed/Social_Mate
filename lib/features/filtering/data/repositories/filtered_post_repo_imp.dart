// i think we need to declare customized exceptions ??

import 'package:social_media/features/filtering/could_be_shared/network_info/network_info.dart';
import 'package:social_media/features/filtering/data/datasources/filtered_posts_remote_source.dart';
import 'package:social_media/features/filtering/domain/entities/post_entity.dart';
import 'package:social_media/features/filtering/domain/repositories/filtered_post_repo.dart';

class FilteredPostRepoImp implements FilteredPostRepo {
  final FilteredPostsRemoteSource filteredPostsRemoteSource;
  final NetworkInfo networkInfo;

  FilteredPostRepoImp(this.networkInfo, {required this.filteredPostsRemoteSource});
  @override
  Future<List<PostEntity>> getFilteredPosts(
      {Map<String, dynamic>? queryParameters}) async {
    if (await networkInfo.isConnected) {
      try {
        final postModels = await filteredPostsRemoteSource.getFilteredPosts(
            queryParameters: queryParameters);
//TODO: this part is new for me , the expand part , but i understand why we get into this shit
        final postEntites = postModels
            .map((postModel) =>
                postModel.data.map((postItem) => postItem.toEntity()).toList())
            .expand((element) => element)
            .toList();
        return postEntites;
      } catch (e) {
        throw Exception('Failed to fetch filtered posts: $e');
      }
    } else {
      throw Exception('No internet connection');
    }
  }
}
