import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthSignInState());

  void toggleAuth() {
    if (state is AuthSignInState) {
      emit(AuthSignUpState());
    } else {
      emit(AuthSignInState());
    }
  }
}
