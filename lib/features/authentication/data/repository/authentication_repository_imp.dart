import 'package:social_media/features/authentication/data/data_source/AuthenticaionRemoteDataSource.dart';
import 'package:social_media/features/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  final AuthenticationRemoteDataSource logInRemoteDataSource;
  // final NetworkInfo networkInfo;

  AuthenticationRepositoryImp({required this.logInRemoteDataSource});
  @override
  Future<String> signIn(String email, String password) async {
    // if (await networkInfo.isConnected) {
      final token = await logInRemoteDataSource.login(email, password);
      return token;
    // } else {
    //   throw Exception('No internet connection');
    // }
  }

  @override
  Future signUp(String firstName, String lastName, String email, String phone, String password, String selectedGender) async {
    // if (await networkInfo.isConnected) {
      final response = await logInRemoteDataSource.signUp(firstName, lastName, email, phone, password, selectedGender);

      print('reponse in repository $response');
      return response;
    // } else {
    //   throw Exception('No internet connection');
    // }
  }
}
