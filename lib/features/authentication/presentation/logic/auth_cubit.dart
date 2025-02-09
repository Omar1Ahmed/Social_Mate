import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/error/errorResponseModel.dart';
import 'package:social_media/core/helper/SharedPref/SharedPrefKeys.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_state.dart';
import 'package:social_media/features/authentication/domain/repository/authentication_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository authenticationRepository;
  AuthCubit(this.authenticationRepository) : super(AuthSignUpState());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController retypePassController = TextEditingController();

  final Map<String, Icon> genderIcons = {
    'Male': Icon(Icons.male, color: Colors.blue),
    'Female': Icon(Icons.female, color: Colors.pinkAccent),
  };


  String _selectedGender = 'Male';

  bool _isRememberMe = false;
  bool _IsSignIn = true;


  bool get isRememberMe => _isRememberMe;

  set isRememberMe(bool value) {
    _isRememberMe = value;
  }

  String get selectedGender => _selectedGender;

  set selectedGender(String value) {
    _selectedGender = value;

    emit(changeGenderState());
  }

  bool get IsSignIn => _IsSignIn;

  set IsSignIn(bool value) {

    clearFields([firstNameController, lastNameController,emailController, phoneController,passController,retypePassController]);

    _IsSignIn = value;
  }

  void toggleAuth() {
    if (IsSignIn) {
      emit(AuthSignUpState());
    } else {
      emit(AuthSignInState());
    }
    IsSignIn = !IsSignIn;

  }

  void clearFields(List<TextEditingController> controllers) {
    for (TextEditingController controller in controllers) {
      controller.clear();
    }
  }


  Future<void> logIn(BuildContext context) async {
    print(emailController.text);
    print(passController.text);

  if(emailController.text.isEmpty && passController.text.isEmpty) {
    emit(AuthLogInErrorState(message: "Please enter required fields"));
  return;
  }
  if(isValidEmail(emailController.text) == false) {
    emit(AuthLogInErrorState(message: "Please enter valid email"));
    return;
  }


  if (state is AuthLoadingState) return;
  emit(AuthLoadingState());
  try {
    final token = await authenticationRepository.signIn(
        emailController.text, passController.text);

    if (token.isNotEmpty) {
      print(token); // log the token
      context.read<userMainDetailsCubit>().decodeAndAssignToken(
          token); // Decode And Assign Token

      if(isRememberMe) {
        final SharedPrefHelper _sharedPrefHelper = getIt<SharedPrefHelper>();
        await _sharedPrefHelper.saveString(SharedPrefKeys.tokenKey, token);
      }
      userMainDetailsState userDetailsState = context
          .read<userMainDetailsCubit>()
          .state;

      if (userDetailsState is userMainDetailsErrorState) {
        print(userDetailsState.message);
        emit(AuthLogInErrorState(message: userDetailsState.message));
      } else {
        emit(AuthLogInTokenRetrivedState());
      }
    } else {
      print('token is not retrived well');
    }
  } catch (e) {
    String errMsg = '';
    print('cubit exeption $e');
    if(e is ErrorResponseModel){
          if (e.message.toString().contains('Internal Server')) {
            errMsg = "Server Error, please try again later";
          } else if (e.message.toString().contains('Invalid credentials')) {
            errMsg = "Wrong email or password, please try again";
          }
        }else{
          errMsg = e.toString();
        }
        emit(AuthLogInErrorState(message: errMsg));
  }

  }


  Future<void> signUp(BuildContext context) async {

    print(firstNameController.text[0].toUpperCase()+ firstNameController.text.substring(1));
    print(lastNameController.text[0].toUpperCase()+ lastNameController.text.substring(1));
    print(emailController.text);
    print(phoneController.text);
    print(passController.text);
    print(retypePassController.text);

      if (state is AuthLoadingState) return;

      if(firstNameController.text.isEmpty && lastNameController.text.isEmpty && emailController.text.isEmpty && passController.text.isEmpty && retypePassController.text.isEmpty) {
      emit(AuthLogInErrorState(message: "Please enter required fields"));
      return;
    }

      if(isValidEmail(emailController.text) == false) {
        emit(AuthLogInErrorState(message: "Please enter valid email"));
        return;
      }

      if(int.tryParse(phoneController.text) == null && phoneController.text.length != 11 && !phoneController.text.startsWith('010') && !phoneController.text.startsWith('011') && !phoneController.text.startsWith('012') && !phoneController.text.startsWith('015') ) {
        print('phone is not valid: ${phoneController.text.length}');
        emit(AuthLogInErrorState(message: "Please enter valid phone number"));
        return;
      }

      if (passController.text != retypePassController.text) {
        emit(AuthLogInErrorState(message: "Password doesn't match"));
        return;
      }


      emit(AuthLoadingState());
      try {
        final response = await authenticationRepository.signUp(
            firstNameController.text[0].toUpperCase()+ firstNameController.text.substring(1), lastNameController.text[0].toUpperCase()+ lastNameController.text.substring(1),emailController.text,
            phoneController.text, passController.text, selectedGender[0]);


        print('sign up response11111111 : $response');


        if(response['statusCode'] == 201){
          emit(AuthRegisterSuccessState());
        }

      } catch (e) {
        String errMsg = '';
        print('cubit exeption ${e}');
        if(e is ErrorResponseModel){
        print('cubit exeption ${e.message}');
          if (e.message.toString().contains('Internal Server')) {
            errMsg = "Server Error, please try again later";
          } else if (e.message.toString().contains('Invalid credentials')) {
            errMsg = "Wrong email or password, please try again";
          }else{
            errMsg = e.message.toString();
          }
        }else{
          errMsg = e.toString();
        }
        emit(AuthLogInErrorState(message: errMsg));
      }



  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNumber(String phone) {
    final RegExp phoneRegex = RegExp(r'^[0-9]{8,15}$'); // Allows 8-15 digits
    return phoneRegex.hasMatch(phone);
  }

}
