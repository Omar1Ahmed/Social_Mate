import 'package:social_media/features/filtering/data/models/filtered_user_model.dart';

abstract class FilteredUsersRepo {
  Future<List<UserModel>> getFilteredUsers(
      {required Map<String, dynamic> queryParameters, required String token});
}