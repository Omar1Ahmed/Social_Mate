// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

part 'token_state.dart';

class TokenCubit extends Cubit<TokenState> {
  TokenCubit() : super(TokenState(token: null));

  void setToken(String token) {
    emit(state.copyWith(token: token));
  }

  void clearToken() {
    emit(state.copyWith(token: null));
  }
}
