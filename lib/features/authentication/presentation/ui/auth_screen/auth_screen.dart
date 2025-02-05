import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/SharedPref/SharedPrefKeys.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_state.dart';
import 'package:social_media/features/authentication/presentation/ui/auth_screen/sign_up_screen.dart';
import 'package:social_media/features/authentication/presentation/ui/widgets/customButton.dart';

import '../../../../../core/routing/routs.dart';
import 'sign_in_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: InfoWidget(builder: (context, info) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsetsDirectional.only(start: info.screenWidth * 0.1, end: info.screenWidth * 0.1, top: info.screenHeight * 0.15),
              child: Column(

                children: [

                  Center(
                    child: Image.asset("assets/images/fullLogo.png", height: info.screenHeight * 0.1),
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return AuthHeader(
                        isSignIn: state is AuthSignInState,
                        onToggle: () => context.read<AuthCubit>().toggleAuth(),
                      );
                    },
                  ),

                  Container(
                    height: info.screenHeight * 0.41,
                    margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.016),
                    child: Column(
                        children: [


                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return state is AuthSignInState ? SignInForm() : SignUpForm();
                            },
                          ),
                        ]),
                  ),


                  SizedBox(
                    width: info.screenWidth * 0.6,
                    child: CustomButton(
                        text: "Join Now",
                        onPressed: () async {
                          final SharedPrefHelper _sharedPrefHelper = getIt<SharedPrefHelper>();
                          await _sharedPrefHelper.saveString(SharedPrefKeys.testKey, 'Cached Data');

                            print('assign Token in Sign up ');
                            // ignore: use_build_context_synchronously
                          context.read<AuthCubit>().login(context);
                            // dynamic token = context.read<JwtCubit>().decodeToken(""); // Start decoding.

                          context.pushNamed(Routes.homePage);
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class AuthHeader extends StatelessWidget {
  final bool isSignIn;
  final VoidCallback onToggle;

  const AuthHeader({super.key, required this.isSignIn, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: isSignIn ? null : onToggle,
            child: Text(
              "Sign in",
              style: TextStyle(fontSize: info.screenWidth * 0.04, fontWeight: FontWeight.bold, color: isSignIn ? Colors.black : Colors.grey),
            ),
          ),
          SizedBox(width: info.screenWidth * 0.05),
          GestureDetector(
            onTap: isSignIn ? onToggle : null,
            child: Text(
              "Sign up",
              style: TextStyle(fontSize: info.screenWidth * 0.04, fontWeight: FontWeight.bold, color: isSignIn ? Colors.grey : Colors.black),
            ),
          ),
        ],
      );
    });
  }
}
