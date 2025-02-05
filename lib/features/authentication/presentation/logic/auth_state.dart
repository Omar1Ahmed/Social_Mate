abstract class AuthState {}

// those 2 states is for the auth screen , toggle between sign in and sign up
// don't remove them
class AuthSignInState extends AuthState {}
class AuthSignUpState extends AuthState {}



class AuthLoadingState extends AuthState {}
class AuthLogInTokenRetrivedState extends AuthState {
  final String token; 
  AuthLogInTokenRetrivedState({required this.token});
}
class AuthLogInErrorState extends AuthState {
  final String message;
  AuthLogInErrorState({required this.message});
}