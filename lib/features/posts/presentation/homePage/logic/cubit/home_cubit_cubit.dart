// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/entities/post_entity.dart';
import '../../../../data/model/post_response.dart';
import '../../../../domain/repository/post_repository.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.postRepository) : super(HomeCubitInitial());
  final PostRepository postRepository;
  Future<void> getPosts() async {
    try {
      emit(PostLoading());
      final (
        posts,
        total
      ) = await postRepository.getPosts();
      emit(PostLoaded(posts, total));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> onRefresh() async {
    try {
      emit(PostLoading());
      final (
        posts,
        total
      ) = await postRepository.getPosts();
      emit(PostLoaded(posts, total));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> createPost(String title, String content) async {
    final post = CreatePostData(title: title, content: content);
    try {
      emit(PostLoading());
      await postRepository.createPost(post);
      emit(PostCreated());
      await getPosts();
      emit(PostLoaded([], 0));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
