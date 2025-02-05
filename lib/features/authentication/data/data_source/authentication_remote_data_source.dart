import 'package:social_media/features/filtering/could_be_shared/network_clients/dio_network_client.dart';

abstract class AuthenticationRemoteDataSource {
  //login setup by marwan
  Future<String> login(String email, String password);
}

class AuthenticationRemoteDataSourceImp
    implements AuthenticationRemoteDataSource {
  // this is the network client mad eby marwan , you don't need yo use it , use yours 3ady
  final DioNetworkClient dioNetworkClient;

  AuthenticationRemoteDataSourceImp({required this.dioNetworkClient});
  // login setup by marwan
  @override
  Future<String> login(String email, String password) async {
    try {

      final response = await dioNetworkClient.post(
        'auth/login',
        data: {'username': email, 'password': password},
      );
      if (response.data is Map && response.data.containsKey('token')) {
        final token = response.data['token'] as String;
        return token;
      } else {
        throw Exception('Invalid response format: Token not found');
      }
    } catch (e) {
      print('Login Error: $e');
      rethrow;
    }
  }
}
