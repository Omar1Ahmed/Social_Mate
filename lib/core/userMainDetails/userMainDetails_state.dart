
import 'package:equatable/equatable.dart';

class userMainDetailsState extends Equatable {
  final String? token;
  final int? userId;
  final int? iat; // Issued At
  final int? exp; // Expiration Time
  final List<int>? rolesIds;
  final String? sub; // Subject

  userMainDetailsState({
    this.token,
    this.userId,
    this.iat,
    this.exp,
    this.rolesIds,
    this.sub,
  });

  userMainDetailsState copyWith({
    String? token,
    int? userId,
    int? iat,
    int? exp,
    List<int>? rolesIds,
    String? sub,
  }) {
    return userMainDetailsState(
      token: token ?? this.token,
      userId: userId ?? this.userId,
      iat: iat ?? this.iat,
      exp: exp ?? this.exp,
      rolesIds: rolesIds ?? this.rolesIds,
      sub: sub ?? this.sub,
    );
  }

  @override
  List<Object?> get props => [token, userId, iat, exp, rolesIds, sub];
}

class userMainDetailsErrorState extends userMainDetailsState {
  final String message;

  userMainDetailsErrorState({required this.message}) : super();
}