// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:social_media/features/filtering/domain/entities/post_entity.dart';
import 'package:social_media/features/filtering/domain/repositories/filtered_post_repo.dart';

part 'filtering_state.dart';

class FilteringCubit extends Cubit<FilteringState> {
  final FilteredPostRepo filteredPostRepo;

  FilteringCubit(this.filteredPostRepo) : super(FilteringInitial());

  Future<void> getFilteredPosts({Map<String, dynamic>? queryParameters}) async {
    if (state is FilteredPostsIsLoading) return; // Prevent duplicate requests
    emit(FilteredPostsIsLoading());
    try {
      final filteredPosts = await filteredPostRepo.getFilteredPosts(
          queryParameters: queryParameters);
          print("Filtered Posts: ${filteredPosts.length} items"); // Debugging
      emit(FilteredPostsIsLoaded(filteredPosts));
    } catch (e) {
      emit(FilteredPostsHasError(e.toString()));
    }
  }
}
