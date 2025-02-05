import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/authentication/domain/repository/authentication_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository authenticationRepository;
  AuthCubit(this.authenticationRepository) : super(AuthSignUpState());

  void toggleAuth() {
    if (state is AuthSignInState) {
      emit(AuthSignUpState());
    } else {
      emit(AuthSignInState());
    }
  }

  // login function by marwan
  Future<void> logIn(String email, String password) async {
    if (state is AuthSignInState) {
      if (state is AuthLoadingState) return;
      emit(AuthLoadingState());
      try {
        final token = await authenticationRepository.signIn(email, password);
        if (token.isNotEmpty) {
          print(token); // log the token
          emit(AuthLogInTokenRetrivedState(token: token));
          //TODO: i think the decryption function should be here
        } else {
          print('token is not retrived well');
        }
      } catch (e) {
        emit(AuthLogInErrorState(message: e.toString()));
      }
    }
  }
}
