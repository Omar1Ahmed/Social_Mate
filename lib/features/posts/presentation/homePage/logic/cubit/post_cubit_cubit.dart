// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entity/post_entity.dart';
import '../../../../domain/repository/post_repository.dart';

part 'post_cubit_state.dart';

class PostCubitCubit extends Cubit<PostCubitState> {
  final PostRepository repository;

  PostCubitCubit(this.repository) : super(PostCubitInitial());
  Future<void> fetchPosts() async {
    emit(PostLoading());
    try {
      final result = await repository.getPosts();
      emit(PostLoaded(result.$1, result.$2));
    } on DioException catch (e) {
      emit(PostError(e.message ?? 'Network error'));
    } catch (e) {
      emit(PostError('Unexpected error'));
    }
  }
}
