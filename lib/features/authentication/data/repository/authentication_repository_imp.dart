import 'package:social_media/features/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:social_media/features/authentication/domain/repository/authentication_repository.dart';
import 'package:social_media/features/filtering/could_be_shared/network_info/network_info.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  final AuthenticationRemoteDataSource logInRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImp({required this.logInRemoteDataSource,required  this.networkInfo});
  @override
  Future<String> signIn(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await logInRemoteDataSource.login(email, password);
        return token;
      } catch (e) {
        throw Exception('Failed to sign in: $e');
      }
    }else{
      throw Exception('No internet connection');
    }
  }
}
