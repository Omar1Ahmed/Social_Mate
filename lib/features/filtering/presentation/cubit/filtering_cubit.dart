// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:social_media/features/filtering/domain/entities/post_entity.dart';
import 'package:social_media/features/filtering/domain/repositories/filtered_post_repo.dart';

part 'filtering_state.dart';

class FilteringCubit extends Cubit<FilteringState> {
  final FilteredPostRepo filteredPostRepo;
  int _pageOffset = 0;
  final int _pageSize = 5;
  bool _hasMore = true;

  FilteringCubit(this.filteredPostRepo) : super(FilteringInitial());

  Future<void> getFilteredPosts(
      {Map<String, dynamic>? queryParameters, required String token}) async {
    if (state is FilteredPostsIsLoading) return;
    emit(FilteredPostsIsLoading());

    try {
      final filteredPosts = await filteredPostRepo.getFilteredPosts(
        queryParameters: {
          ...?queryParameters,
          'pageOffset': _pageOffset,
          'pageSize': _pageSize
        },
        token: token,
      );
      print("Filtered Posts: ${filteredPosts.length} items"); // Debug log
      if (filteredPosts.isEmpty) {
        emit(FilteredPostsIsEmpty(filteredPosts));
      } else {
        _hasMore = filteredPosts.length == _pageSize;
        emit(FilteredPostsIsLoaded(filteredPosts, _hasMore));
      }
    } catch (e) {
      emit(FilteredPostsHasError(e.toString()));
    }
  }

  Future<void> loadMoreFilteredPosts({
    Map<String, dynamic>? queryParameters,
    required String token,
  }) async {
    if (state is FilteredPostsIsLoadingMore || !_hasMore) return;

    emit(FilteredPostsIsLoadingMore(
        (state as FilteredPostsIsLoaded).filteredPosts));

    try {
      _pageOffset += _pageSize;
      final newPosts = await filteredPostRepo.getFilteredPosts(
        queryParameters: {
          ...?queryParameters,
          'pageOffset': _pageOffset,
          'pageSize': _pageSize
        },
        token: token,
      );

      if (newPosts.isEmpty) {
        _hasMore = false;
        emit(FilteredPostsIsLoaded(
            (state as FilteredPostsIsLoadingMore).filteredPosts, false));
      } else {
        // i faced this line before☝
        final updatedPosts = [
          ...(state as FilteredPostsIsLoadingMore).filteredPosts,
          ...newPosts
        ];
        _hasMore =
            newPosts.length == _pageSize; // Check if more posts are available
        emit(FilteredPostsIsLoaded(updatedPosts, _hasMore));
      }
    } catch (e) {
      emit(FilteredPostsHasError(e.toString()));
    }
  }

  Future<void> refreshFilteredPosts({
    Map<String, dynamic>? queryParameters,
    required String token,
  }) async {
    if (state is FilteredPostsIsLoading)
      return; // i liked this to prevent double loading
    emit(FilteredPostsIsLoading());

    try {
      _pageOffset = 0;
      final filteredPosts = await filteredPostRepo.getFilteredPosts(
        queryParameters: {
          ...?queryParameters,
          'pageOffset': _pageOffset,
          'pageSize': _pageSize
        },
        token: token,
      );

      if (filteredPosts.isEmpty) {
        emit(FilteredPostsIsEmpty(filteredPosts));
      } else {
        _hasMore = filteredPosts.length == _pageSize;
        emit(FilteredPostsIsLoaded(filteredPosts, _hasMore));
      }
    } catch (e) {
      emit(FilteredPostsHasError(e.toString()));
    }
  }
}
