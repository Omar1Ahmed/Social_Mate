// domain/repositories/post_repository.dart

import 'package:social_media/core/entities/post_entity.dart';

abstract class PostDetailsRepository {
   Future<PostEntity> getPostDetails(int postId);
}