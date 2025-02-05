import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/core/userMainDetails/jwt_token_decode/data/model/jwtModel.dart';
import 'package:social_media/core/userMainDetails/jwt_token_decode/data/repository/jwt_token_decode_repository_imp.dart';
import 'userMainDetails_state.dart';


class userMainDetailsCubit extends Cubit<userMainDetailsState> {
  final JwtTokenDecodeRepositoryImp _repository;

  userMainDetailsCubit(this._repository)
      : super(userMainDetailsState(token: null));

  Future<void> decodeAndAssignToken(String token) async {
    try {
      final JwtModel jwt = _repository.decodeToken(token);

      emit(state.copyWith(
        token: token,
        userId: jwt.userId,
        iat: jwt.iat,
        exp: jwt.exp,
        rolesIds: jwt.rolesIds,
        sub: jwt.sub,
      ));
    } catch (e) {
      print(e);
      emit(userMainDetailsErrorState(message: e.toString()));
    }
  }

}