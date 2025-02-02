// data/datasources/post_remote_data_source_impl.dart
import 'package:dio/dio.dart';

import '../../domain/repository/post_remote_data_source.dart';
import '../model/post_response.dart';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl({required this.dio});

  @override
 @override
Future<PostResponse> getPosts() async {
  final posts = PostResponse(
    data: [
      PostData(
        id: 1,
        title: 'title 1',
        content: 'content 1',
        createdBy: User(id: 1, fullName: 'user 1'),
        createdOn: DateTime.now(),
      ),
      PostData(
        id: 2,
        title: 'title 2',
        content: 'content 2',
        createdBy: User(id: 2, fullName: 'user 2'),
        createdOn: DateTime.now(),
      ),
      PostData(
        id: 3,
        title: 'title 3',
        content: 'content 3',
        createdBy: User(id: 3, fullName: 'user 3'),
        createdOn: DateTime.now(),
      ),
      PostData(
        id: 4,
        title: 'title 4',
        content: 'content 4',
        createdBy: User(id: 4, fullName: 'user 4'),
        createdOn: DateTime.now(),
      ),
      PostData(
        id: 5,
        title: 'title 5',
        content: 'content 5',
        createdBy: User(id: 5, fullName: 'user 5'),
        createdOn: DateTime.now(),
      ),
    ],
    total: 5,
  );

  return posts;
}
}
