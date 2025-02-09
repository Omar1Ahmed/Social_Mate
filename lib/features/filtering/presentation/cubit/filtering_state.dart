part of 'filtering_cubit.dart';

abstract class FilteringState {}

class FilteringInitial extends FilteringState {}

class FilteredPostsIsLoading extends FilteringState {}

class FilteredPostsIsLoaded extends FilteringState {
  final List<FilteringPostEntity> filteredPosts;
  final bool hasMore;

  FilteredPostsIsLoaded(this.filteredPosts, this.hasMore);

  // Add a copyWith method for partial updates
  FilteredPostsIsLoaded copyWith({
    List<FilteringPostEntity>? filteredPosts,
    bool? hasMore,
  }) {
    return FilteredPostsIsLoaded(
      filteredPosts ?? this.filteredPosts,
      hasMore ?? this.hasMore,
    );
  }
}

class FilteredPostsIsEmpty extends FilteringState {
  final List<FilteringPostEntity> filteredPosts;
  FilteredPostsIsEmpty(this.filteredPosts);
}

class FilteredPostsHasError extends FilteringState {
  final String message;
  FilteredPostsHasError(this.message);
}

class FilteredPostsIsLoadingMore extends FilteringState {
  final List<FilteringPostEntity> filteredPosts;
  FilteredPostsIsLoadingMore(this.filteredPosts);
}
