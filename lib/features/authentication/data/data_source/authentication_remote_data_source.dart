import 'package:social_media/core/network/dio_client.dart';
import 'package:social_media/features/authentication/data/data_source/AuthenticaionRemoteDataSource.dart';



class AuthenticationRemoteDataSourceImp implements AuthenticationRemoteDataSource {
  // this is the network client mad eby marwan , you don't need yo use it , use yours 3ady
  final DioClient dioNetworkClient;

  AuthenticationRemoteDataSourceImp({required this.dioNetworkClient});
  // login setup by marwan
  @override
  Future<String> login(String email, String password) async {
      print('url : ${dioNetworkClient.baseUrl}');
      final response = await dioNetworkClient.post(
        'auth/login',
        body: {'username': email, 'password': password},
      );
      if (response.containsKey('token')) {
        final token = response['token'] as String;
        return token;
      } else {
        throw Exception('Invalid response format: Token not found');
      }

  }

  @override
  Future signUp(String firstName, String lastName, String email, String phone, String password, String selectedGender) async {

    print('url : ${dioNetworkClient.baseUrl}');

    print('''{
    "firstName": "$firstName",
    "lastName": "$lastName",
    "mobileNumber": "$phone",
    "password": "$password",
        "email": "$email",
        "gender": "$selectedGender"}''');

    final response = await dioNetworkClient.post(
      'auth/register',
      body: {
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": phone,
        "password": password,
        "email": email,
        "gender": selectedGender},
      header: {
        "Content-Type": "application/json"
      }
    );


     print('data source : ${response}');
      return response;


  }
}
