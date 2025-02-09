import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/SharedPref/SharedPrefKeys.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_state.dart';
import 'package:social_media/features/authentication/presentation/ui/auth_screen/sign_up_screen.dart';
import 'package:social_media/features/authentication/presentation/ui/widgets/customButton.dart';
import 'package:cherry_toast/cherry_toast.dart';
import '../../../../../core/routing/routs.dart';
import 'sign_in_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthLogInTokenRetrivedState) {
          Navigator.pushNamed(context, Routes.homePage);
        }
        if (state is AuthRegisterSuccessState) {
          CherryToast.success(
            title: Text(
              "Success",
              style: TextStyle(color: Colors.white),
            ),
            toastDuration: Duration(seconds: 3),
            borderRadius: info.screenWidth * 0.04,
            backgroundColor: Colors.green,
            shadowColor: Colors.black45,
            animationDuration: Duration(milliseconds: 300),
            animationType: AnimationType.fromTop,
            autoDismiss: true,
            description: Text(
              'Successfully Registered',
              style: TextStyle(color: Colors.white70),
            ),
          ).show(context);
          context.read<AuthCubit>().toggleAuth();
        }
      }, builder: (context, state) {
        print('state: $state');
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  start: info.screenWidth * 0.1,
                  end: info.screenWidth * 0.1,
                  top: info.screenHeight * 0.15),
              child: Column(
                children: [
                  Center(
                    child: Image.asset("assets/images/fullLogo.png",
                        height: info.screenHeight * 0.1),
                  ),
                  AuthHeader(
                    isSignIn: context.read<AuthCubit>().IsSignIn,
                    onToggle: () => context.read<AuthCubit>().toggleAuth(),
                  ),
                  Container(
                    height: info.screenHeight * 0.47,
                    margin: EdgeInsetsDirectional.only(
                        top: info.screenHeight * 0.016),
                    child: Column(children: [
                      context.read<AuthCubit>().IsSignIn
                          ? SignInForm()
                          : SignUpForm(),
                    ]),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Checkbox(
                  //       value: rememberMe,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           rememberMe = value!;
                  //         });
                  //       },
                  //     ),
                  //     Text('Remember Me'),
                  //   ],
                  // ),
                  SizedBox(
                    width: info.screenWidth * 0.6,
                    child: CustomButton(
                        text: "Join Now",
                        onPressed: () async {
                          if (context.read<AuthCubit>().IsSignIn) {
                            final SharedPrefHelper _sharedPrefHelper =
                                getIt<SharedPrefHelper>();
                            await _sharedPrefHelper.saveString(
                                SharedPrefKeys.testKey, 'Cached Data');
//  // ignore: use_build_context_synchronously
//                           context.read<AuthCubit>().login(context);
//                             // dynamic token = context.read<JwtCubit>().decodeToken(""); // Start decoding.
                            //context.read<TokenCubit>().setToken('token Test ');

                            //saving token starts from here👇 : sign in or sign up then save
                            // if (rememberMe) {
                            //   context.read<AuthCubit>().logIn(context);
                            //   final token = context
                            //       .read<userMainDetailsCubit>()
                            //       .state
                            //       .token;
                            //   print(
                            //       'token before being saved and after sign in: $token');
                            //
                            //   Future.delayed(Duration(seconds: 15), () {
                            //     saveToken(context
                            //         .read<userMainDetailsCubit>()
                            //         .state
                            //         .token!);
                            //   });
                            // } else {

                              context.read<AuthCubit>().logIn(context);
                            // }
                          } else {
                            //print('Sign up clicked');
                            // if (rememberMe) {
                            //   context.read<AuthCubit>().signUp(context);
                            //   final token = context
                            //       .read<userMainDetailsCubit>()
                            //       .state
                            //       .token;
                            //   print(
                            //       'token before being saved and after sign up: $token');
                            //   Future.delayed(Duration(seconds: 15), () {
                            //     saveToken(context
                            //         .read<userMainDetailsCubit>()
                            //         .state
                            //         .token!);
                            //   });
                            // } else {
                            // }
                              context.read<AuthCubit>().signUp(context);
                          }
                        }),
                  ),
                  if (state is AuthLogInErrorState)
                    Container(
                        margin: EdgeInsetsDirectional.only(
                            top: info.screenHeight * 0.02),
                        child: Text(
                          state.message,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: info.screenWidth * 0.04),
                        )),
                ],
              ),
            ),
          ),
        );
      });
    });
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
            onTap: onToggle,
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontSize: info.screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: isSignIn ? Colors.black : Colors.grey),
            ),
          ),
          SizedBox(width: info.screenWidth * 0.05),
          GestureDetector(
            onTap: onToggle,
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontSize: info.screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: isSignIn ? Colors.grey : Colors.black),
            ),
          ),
        ],
      );
    });
  }
}
