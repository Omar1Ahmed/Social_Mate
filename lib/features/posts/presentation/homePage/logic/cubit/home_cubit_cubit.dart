import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import '../../../../../../core/entities/post_entity.dart';
import '../../../../data/model/post_response.dart';
import '../../../../domain/repository/post_repository.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.postRepository) : super(HomeCubitInitial());

  final PostRepository postRepository;

  int _currentPage = 1;
  final int _pageSize = 4;
  bool hasMorePosts = true;
  bool isLoadingMore = false;

  Future<void> getPosts() async {
    if (state is PostLoading || state is PostLoaded) return;

    emit(PostLoading());

    try {
      final (
        posts,
        total
      ) = await postRepository.getPosts(_currentPage, _pageSize);

      hasMorePosts = (_currentPage * _pageSize) < total;

      emit(PostLoaded(posts, total));
    } catch (e) {
      emit(
        PostError(e.toString()),
      );
    }
  }

  // Load more posts
  Future<void> loadMorePosts() async {
    if (isLoadingMore || state is! PostLoaded || !hasMorePosts) return;
    isLoadingMore = true;

    final currentState = state as PostLoaded;
    emit(PostLoadingMore(currentState.posts, currentState.total));

    try {
      final (
        newPosts,
        total
      ) = await postRepository.getPosts(_currentPage + 1, _pageSize);

      if (newPosts.isEmpty) {
        hasMorePosts = false;
      } else {
        _currentPage++;
        final updatedPosts = List<PostEntity>.from(currentState.posts)..addAll(newPosts);
        hasMorePosts = (_currentPage * _pageSize) < total;
        emit(PostLoaded(updatedPosts, total));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  // Handle refresh action
  Future<void> onRefresh() async {
    _currentPage = 1;
    hasMorePosts = true;
    emit(HomeCubitInitial());
    await getPosts();
  }

  // Create a new post
  Future<void> createPost(String title, String content) async {
    final post = CreatePostData(title: title, content: content);

    try {
      emit(PostLoading());
      await postRepository.createPost(post);
      emit(PostCreated());
      await onRefresh();
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      // Emit loading state for post deletion
      emit(PostDeletedLoading());

      await postRepository.deletePost(postId);

      if (state is PostLoaded) {
        final currentState = state as PostLoaded;
        final updatedPosts = currentState.posts.where((post) => post.id != postId).toList();

        final updatedTotal = currentState.total - 1;

        emit(PostLoaded(updatedPosts, updatedTotal));
      }

      // Emit success state for post deletion
      emit(PostDeleted());
    } catch (e) {
      // Log the error and emit an error state
      print('Error deleting post: $e');
      emit(PostDeleteFailed(e.toString()));
    }
  }
}
