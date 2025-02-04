part of 'filtering_cubit.dart';

abstract class FilteringState {
}

class FilteringInitial extends FilteringState {
}

class FilteredPostsIsLoading extends FilteringState {
}

class FilteredPostsIsLoaded extends FilteringState {
final List<PostEntity> filteredPosts;
FilteredPostsIsLoaded(this.filteredPosts);
}

class FilteredPostsHasError extends FilteringState {
  final String message;
  FilteredPostsHasError( this.message);
}
