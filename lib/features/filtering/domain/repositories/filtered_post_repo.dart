import 'package:social_media/features/filtering/domain/entities/filtering_post_entity.dart';

abstract class FilteredPostRepo {
  Future<List<FilteringPostEntity>> getFilteredPosts(
      {Map<String, dynamic>? queryParameters, required String token});
}
