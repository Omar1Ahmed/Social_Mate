// data/datasources/post_remote_data_source_impl.dart
import 'package:dio/dio.dart';

import '../../domain/repository/post_remote_data_source.dart';
import '../model/post_response.dart';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl({required this.dio});

  @override
  Future<PostResponse> getPosts() async {
    final response = await dio.get('/posts');
    return PostResponse.fromJson(response.data);
  }
}