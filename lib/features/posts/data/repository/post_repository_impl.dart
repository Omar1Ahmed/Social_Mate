// PostRepository interface
import 'package:social_media/core/entities/post_entity.dart';
import 'package:social_media/features/posts/data/model/post_response.dart';
import 'package:social_media/features/posts/domain/repository/post_remote_data_source.dart';

import '../../domain/repository/post_repository.dart';



class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<(List<PostEntity>, int)> getPosts() async {
    final response = await remoteDataSource.getPosts();
    return (response.toEntities(), response.total);
  }
  
  @override
  Future<void> createPost(CreatePostData post) async {
   final response = await remoteDataSource.createPost(post);
    return response;
  }


}