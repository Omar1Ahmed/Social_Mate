import 'package:bloc/bloc.dart';
import 'package:social_media/features/filtering/domain/entities/post_entity.dart';

part 'sharing_data_state.dart';

class SharingDataCubit extends Cubit<SharingDataState> {
  SharingDataCubit() : super(SharingDataState());

  void updateQueryParams(Map<String, dynamic> params) {
    emit(state.copyWith(queryParams: params));
  }

  void updatePosts(List<FilteringPostEntity> posts) {
    emit(state.copyWith(posts: posts));
  }
}
