// domain/repositories/post_repository.dart


import 'package:social_media/features/posts/data/model/postDetails/postDetails_reponse.dart';

abstract class PostDetailsRepository {
   Future<PostDetailsModel> getPostDetails(int postId);
}