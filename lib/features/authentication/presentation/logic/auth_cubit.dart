import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_state.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthSignUpState());

  void toggleAuth() {
    if (state is AuthSignInState) {
      emit(AuthSignUpState());
    } else {
      emit(AuthSignInState());
    }
  }

  Future<void> login(BuildContext context) async {


    //Login From Api
    // ...................
    //

    context.read<userMainDetailsCubit>().decodeAndAssignToken('eyJhbGciOiJIUzM4NCJ9.eyJST0xFU19JRFMiOlsyXSwiVVNFUl9JRCI6Niwic3ViIjoiYXNkYXNkMTIzQGdtYWlsLmNvbSIsImlhdCI6MTczODcxMzM1NSwiZXhwIjoxNzM4Nzk5NzU1fQ.SuTdrRlZg7ii0c63HvE09JrabxvAemsWFLPBr5IQGL52WmHfkHG9smIVDNdHHWkf'); // Decode And Assign Token
    userMainDetailsState userDetailsState = context.read<userMainDetailsCubit>().state;
    if( userDetailsState is userMainDetailsErrorState){
      // emit with Error state (AuthErrorState)
      print(userDetailsState.message);

    }else{

      //Emit with Success state (AuthSuccessState)
      print(userDetailsState);

    }

  }
}
