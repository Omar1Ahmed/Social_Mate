// PostRepository interface

import 'package:social_media/core/entities/post_entity.dart';
import 'package:social_media/features/posts/data/model/post_response.dart';
import 'package:social_media/features/posts/domain/data_source/post_remote_data_source.dart';

import '../../domain/repository/post_repository.dart';



class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<(List<PostEntity>, int)> getPosts( int pageOffset, int pageSize) async {
    final response = await remoteDataSource.getPosts( pageOffset, pageSize);
    return (response.toEntities(), response.total);
  }
  
  @override
  Future<PostEntity> createPost(CreatePostData post) async {
   final response = await remoteDataSource.createPost(post);
    return response as PostEntity;
  }
  
  @override
  Future<void> deletePost(int postId) {
    return remoteDataSource.deletePost(postId);
  }


}