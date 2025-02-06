import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/entities/post_entity.dart';
import '../../../../data/model/post_response.dart';
import '../../../../domain/repository/post_repository.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.postRepository) : super(HomeCubitInitial());

  final PostRepository postRepository;

  int _currentPage = 1; // Start with page 1
  final int _pageSize = 4; // Number of posts per page
  bool hasMorePosts = true; // Indicates if there are more posts to load
  bool isLoadingMore = false; // Tracks if more posts are currently being loaded

  // Get initial posts
  Future<void> getPosts() async {
    if (state is PostLoading || state is PostLoaded) return;

    emit(PostLoading()); // Show loading state initially

    try {
      final (
        posts,
        total
      ) = await postRepository.getPosts(_currentPage, _pageSize);

      hasMorePosts = (_currentPage * _pageSize) < total;

      emit(PostLoaded(posts, total)); // Emit the loaded posts
    } catch (e) {
      emit(PostError(e.toString())); // Emit error state if something goes wrong
    }
  }

  // Load more posts
  Future<void> loadMorePosts() async {
    if (isLoadingMore || !(state is PostLoaded) || !hasMorePosts) return;
    isLoadingMore = true; // Set to true to prevent further calls while loading

    final currentState = state as PostLoaded; // Get the current state
    emit(PostLoadingMore(currentState.posts, currentState.total)); // Pass the current posts

    try {
      final (
        newPosts,
        total
      ) = await postRepository.getPosts(_currentPage + 1, _pageSize);

      if (newPosts.isEmpty) {
        hasMorePosts = false; // No more posts to load
        print('No more posts to load.');
      } else {
        _currentPage++;
        final updatedPosts = List<PostEntity>.from(currentState.posts)..addAll(newPosts);
        hasMorePosts = (_currentPage * _pageSize) < total; // Update hasMorePosts flag
        emit(PostLoaded(updatedPosts, total)); // Emit the updated posts
        print('Fetched ${newPosts.length} new posts. Total: $total');
      }
    } catch (e) {
      print('Error loading more posts: $e');
      emit(PostError(e.toString())); // Emit error state if there's an issue
    } finally {
      isLoadingMore = false; // Reset loading flag
      print('Finished loading more posts.');
    }
  }

  // Handle refresh action
  Future<void> onRefresh() async {
    _currentPage = 1; // Reset to first page
    hasMorePosts = true; // Assume there are more posts initially
    await getPosts(); // Fetch posts again
  }

  // Create a new post
  Future<void> createPost(String title, String content) async {
    final post = CreatePostData(title: title, content: content);

    try {
      emit(PostLoading()); // Show loading state while creating post
      await postRepository.createPost(post); // Create the post
      emit(PostCreated()); // Emit success state after creation
      await onRefresh(); // Refresh the posts
    } catch (e) {
      emit(PostError(e.toString())); // Emit error state in case of failure
    }
  }
}
