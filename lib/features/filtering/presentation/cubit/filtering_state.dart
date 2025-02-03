part of 'filtering_cubit.dart';

abstract class FilteringState {
  List<PostEntity> filteredPosts = [];
  FilteringState(this.filteredPosts);
}

class FilteringInitial extends FilteringState {
  FilteringInitial(super.filteredPosts);
}

class FilteredPostsIsLoading extends FilteringState {
  FilteredPostsIsLoading(super.filteredPosts);
}

class FilteredPostsIsLoaded extends FilteringState {
  FilteredPostsIsLoaded(super.filteredPosts);
}

class FilteredPostsHasError extends FilteringState {
  final String message;
  FilteredPostsHasError(super.filteredPosts, this.message);
}
