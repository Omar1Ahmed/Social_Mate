import 'package:social_media/core/network/dio_client.dart';
import 'package:social_media/features/authentication/data/data_source/AuthenticaionRemoteDataSource.dart';

class AuthenticationRemoteDataSourceImp
    implements AuthenticationRemoteDataSource {
  // this is the network client mad eby marwan , you don't need yo use it , use yours 3ady
  final DioClient dioNetworkClient;

  AuthenticationRemoteDataSourceImp({required this.dioNetworkClient});
  // login setup by marwan
  @override
  Future<String> login(String email, String password) async {
    print('url : ${dioNetworkClient.baseUrl}');

    // Make the POST request
    final responseBody = await dioNetworkClient.post(
      '/auth/login',
      body: {'username': email, 'password': password},
    );

    // Debug: Print the full response body
    print('Response Body: $responseBody');

    // Check if the response body contains the token
    if (responseBody['token'] != null) {
      final token = responseBody['token'] as String;
      print('token : $token');
      return token;
    } else {
      throw Exception('Invalid response format: Token not found');
    }
  }

  @override
  Future<Map<String, dynamic>> signUp(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
    String selectedGender,
  ) async {
    print('url : ${dioNetworkClient.baseUrl}');

    // Debug: Print the request body
    print('''{
    "firstName": "$firstName",
    "lastName": "$lastName",
    "mobileNumber": "$phone",
    "password": "$password",
    "email": "$email",
    "gender": "$selectedGender"
  }''');

    // Make the POST request
    final response = await dioNetworkClient.post(
      '/auth/register',
      body: {
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": phone,
        "password": password,
        "email": email,
        "gender": selectedGender,
      },
      header: {
        "Content-Type": "application/json",
      },
    );

    // Debug: Print the full response
    print('Response from Data Source: $response');

    // Return the response body
    return response;
  }
}
