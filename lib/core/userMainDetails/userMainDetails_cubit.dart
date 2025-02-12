import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/core/userMainDetails/jwt_token_decode/data/model/jwtModel.dart';
import 'package:social_media/core/userMainDetails/jwt_token_decode/data/repository/jwt_token_decode_repository_imp.dart';
import '../helper/SharedPref/SharedPrefKeys.dart';
import 'userMainDetails_state.dart';

// ignore: camel_case_types
class userMainDetailsCubit extends Cubit<userMainDetailsState> {
  final JwtTokenDecodeRepositoryImp _repository;
  final SharedPrefHelper _sharedPrefHelper = getIt<SharedPrefHelper>();

  userMainDetailsCubit(this._repository) : super(userMainDetailsState(token: null));

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

  Future<void> getToken() async {
    try {
      final token = _sharedPrefHelper.getString(SharedPrefKeys.tokenKey);
      if (token != null) {
        print('Saved token: $token');
        decodeAndAssignToken(token);
      }
    } catch (e) {
      print(e);
      emit(userMainDetailsErrorState(message: e.toString()));
    }
  }

  Future<void> logOut() async {
    try {
      _sharedPrefHelper.remove(SharedPrefKeys.tokenKey);
      emit(userMainDetailsState(token: null));
    } catch (e) {
      print(e);
      emit(userMainDetailsErrorState(message: e.toString()));
    }
  }
}
