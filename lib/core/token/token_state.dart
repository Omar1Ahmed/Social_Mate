part of 'token_cubit.dart';

class TokenState {
  final String? token;

  TokenState({this.token});

  TokenState copyWith({String? token}) {
    return TokenState(token: token ?? this.token);
  }
}