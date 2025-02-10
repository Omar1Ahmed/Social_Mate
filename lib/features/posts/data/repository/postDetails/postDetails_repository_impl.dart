// PostRepository interface

import 'package:social_media/features/posts/data/model/postDetails/postDetails_reponse.dart';
import 'package:social_media/features/posts/domain/data_source/postDetails/postDetails_remoteDataSource.dart';
import 'package:social_media/features/posts/domain/repository/postDetails/postDetails_repository.dart';

class PostDetailsRepositoryImpl implements PostDetailsRepository {
  PostDetailsRemoteDataSource postDetailsRemoteDataSource;

  PostDetailsRepositoryImpl({required this.postDetailsRemoteDataSource});

  @override
  Future <PostDetailsModel> getPostDetails(int postId) async {

    final response = await postDetailsRemoteDataSource.getPostDetails(postId);

    return response;
  }


}