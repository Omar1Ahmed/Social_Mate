import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/entities/post_entity.dart';
import '../../../../data/model/post_response.dart';
import '../../../../domain/repository/post_repository.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.postRepository) : super(HomeCubitInitial());

  final PostRepository postRepository;

  int _pageOffset = 0;
  final int _pageSize = 10;
  bool _hasMorePosts = true;

  /// Fetches the initial set of posts
  Future<void> getPosts() async {
    try {
      emit(PostLoading());
      final (
        posts,
        total
      ) = await postRepository.getPosts(_pageOffset, _pageSize);
      _hasMorePosts = _pageOffset + _pageSize < total;
      emit(PostLoaded(posts, total));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> loadMorePosts() async {
    if (!_hasMorePosts) return;

    try {
      emit(PostLoadingMore());
      final (
        newPosts,
        total
      ) = await postRepository.getPosts(_pageOffset + _pageSize, _pageSize);
      if (newPosts.isEmpty) {
        _hasMorePosts = false;
        return;
      }
      final currentState = state;
      if (currentState is PostLoaded) {
        final updatedPosts = List<PostEntity>.from(currentState.posts)..addAll(newPosts);
        _pageOffset += _pageSize;
        _hasMorePosts = _pageOffset + _pageSize < total; // Update the hasMorePosts flag
        emit(PostLoaded(updatedPosts, total));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> onRefresh() async {
    _pageOffset = 0;
    _hasMorePosts = true;
    await getPosts();
  }

  /// Creates a new post and updates the list
  Future<void> createPost(String title, String content) async {
    final post = CreatePostData(title: title, content: content);
    try {
      emit(PostLoading());
      await postRepository.createPost(post);
      emit(PostCreated());

      // Refresh the list after creating a new post
      await onRefresh();
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
