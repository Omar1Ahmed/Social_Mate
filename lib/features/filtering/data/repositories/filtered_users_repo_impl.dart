//import 'package:social_media/features/filtering/could_be_shared/network_info/network_info.dart';
import 'package:social_media/core/helper/Connectivity/connectivity_helper.dart';
import 'package:social_media/features/filtering/data/datasources/users_remote_data_source.dart';
import 'package:social_media/features/filtering/data/models/filtered_user_model.dart';
import 'package:social_media/features/filtering/domain/repositories/filtered_users_repo.dart';

class FilteredUsersRepoImpl implements FilteredUsersRepo {
  final UserRemoteDataSource filteredUsersRemoteSource;
  // final NetworkInfo networkInfo;

  FilteredUsersRepoImpl(
      {required this.filteredUsersRemoteSource,
        // required this.networkInfo
      });
  @override
  Future<List<UserModel>> getFilteredUsers(
      {required Map<String, dynamic> queryParameters,
      required String token}) async {
    if (await ConnectivityHelper.isConnected()) {
    try {
      final userModels = await filteredUsersRemoteSource.getFilteredUsers(
          queryParameters: queryParameters, token: token);
      if (userModels.isEmpty) {
        print('UserModel data is empty');
        return [];
      }
      print('userModels in the repo : $userModels');
      return userModels;
    } catch (e) {
      throw Exception('Failed to fetch filtered users: $e');
    }
    } else {
      throw Exception('No internet connection');
    }
  }
}
