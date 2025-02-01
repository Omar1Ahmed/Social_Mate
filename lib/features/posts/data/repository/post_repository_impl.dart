
import '../../domain/entity/post_entity.dart';
import '../../domain/repository/post_repository.dart';
import '../../domain/repository/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<(List<PostEntity>, int)> getPosts() async {
    final response = await remoteDataSource.getPosts();
    return (response.toEntities(), response.total);
  }
}