part of 'filtering_cubit.dart';

abstract class FilteringState {}

class FilteringInitial extends FilteringState {}

class FilteredPostsIsLoading extends FilteringState {}

class FilteredPostsIsLoaded extends FilteringState {
  final bool hasMore;
  final List<FilteringPostEntity> filteredPosts;
  FilteredPostsIsLoaded(this.filteredPosts, this.hasMore);
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
