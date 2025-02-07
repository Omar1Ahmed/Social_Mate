import 'package:bloc/bloc.dart';
import 'package:social_media/features/filtering/data/models/filtered_user_model.dart';
import 'package:social_media/features/filtering/domain/repositories/filtered_users_repo.dart';

part 'filtered_users_state.dart';

class FilteredUsersCubit extends Cubit<FilteredUsersState> {
  final FilteredUsersRepo filteredUsersRepo;
  FilteredUsersCubit({required this.filteredUsersRepo})
      : super(FilteredUsersInitial());

  Future<void> loadFilteredUsers(
      {required Map<String, dynamic> queryParameters,
      required String token}) async {
    emit(FilteredUsersLoading());
    try {
      final filteredUsers = await filteredUsersRepo.getFilteredUsers(
          queryParameters: queryParameters, token: token);
      print('filtered users : $filteredUsers');
      emit(FilteredUsersLoaded(filteredUsers: filteredUsers));
    } catch (e , stackTrace) {
      print('Error: $e\nStackTrace: $stackTrace');
      emit(FilteredUsersError(message: e.toString()));
    }
  }
}
