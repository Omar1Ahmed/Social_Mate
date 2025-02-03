import 'package:social_media/features/filtering/domain/entities/post_entity.dart';

abstract class FilteredPostRepo {
  Future<List<PostEntity>> getFilteredPosts({Map<String, dynamic>? queryParameters});
}