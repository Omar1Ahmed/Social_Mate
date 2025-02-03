// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:social_media/features/filtering/domain/entities/post_entity.dart';
import 'package:social_media/features/filtering/domain/repositories/filtered_post_repo.dart';

part 'filtering_state.dart';

class FilteringCubit extends Cubit<FilteringState> {
  final FilteredPostRepo filteredPostRepo;
  static List<PostEntity> filteredPosts = [];
  FilteringCubit(this.filteredPostRepo) : super(FilteringInitial(List<PostEntity>.empty()));

  Future<void> getFilteredPosts({Map<String, dynamic>? queryParameters}) async {
    emit(FilteredPostsIsLoading(filteredPosts));
    try {
      filteredPosts = await filteredPostRepo.getFilteredPosts(queryParameters: queryParameters);
      emit(FilteredPostsIsLoaded(filteredPosts));
    } catch (e) {
      emit(FilteredPostsHasError(filteredPosts, e.toString()));
    }
  }
}
