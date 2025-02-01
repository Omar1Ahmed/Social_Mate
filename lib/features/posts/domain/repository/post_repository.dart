// domain/repositories/post_repository.dart
import '../entity/post_entity.dart';

abstract class PostRepository {
  Future<(List<PostEntity>, int)> getPosts();
}