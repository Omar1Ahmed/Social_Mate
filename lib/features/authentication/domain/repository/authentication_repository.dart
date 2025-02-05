abstract class AuthenticationRepository {
  // this is for login , you need to add sign up too
  Future<String> signIn(String email, String password);
}