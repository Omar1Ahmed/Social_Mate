import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
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


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: InfoWidget(builder: (context, info) {
      return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthLogInTokenRetrivedState) {
          if(context.read<userMainDetailsCubit>().state.isAdmin == true){
            Navigator.pushNamed(context, Routes.reportsHomeScreen);
          }else if(context.read<userMainDetailsCubit>().state.isMember == true){
            Navigator.pushNamed(context, Routes.homePage);

          }
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: info.screenWidth * 0.1, end: info.screenWidth * 0.1, top: info.screenHeight * 0.15),
              child: Column(
                children: [
                  Center(
                    child: Image.asset("assets/images/fullLogo.png", height: info.screenHeight * 0.1),
                  ),
                  AuthHeader(
                    isSignIn: context.read<AuthCubit>().IsSignIn,
                    onToggle: () => context.read<AuthCubit>().toggleAuth(),
                  ),
                  Container(
                    height: info.screenHeight * 0.47,
                    margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.016),
                    child: Column(children: [
                      context.read<AuthCubit>().IsSignIn ? SignInForm() : SignUpForm(),
                    ]),
                  ),

                  SizedBox(
                    width: info.screenWidth * 0.6,
                    child: CustomButton(
                        text: "Join Now",
                        onPressed: () async {
                          if (context.read<AuthCubit>().IsSignIn) {

                            context.read<AuthCubit>().logIn(
                                  context,
                                );
                          } else {
                            context.read<AuthCubit>().signUp(context);
                          }
                        }),
                  ),
                  if (state is AuthLogInErrorState)
                    Container(
                        margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.02),
                        child: Text(
                          state.message,
                          style: TextStyle(color: Colors.red, fontSize: info.screenWidth * 0.04),
                        )),
                ],
              ),
            ),
          ),
        );
      });
    }));
  }
}

class AuthHeader extends StatelessWidget {
  final bool isSignIn;
  final VoidCallback onToggle;

  const AuthHeader({super.key, required this.isSignIn, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Transparent to show SafeArea effect
      statusBarIconBrightness: Brightness.dark, // Use Brightness.light for white icons
    ));

    return InfoWidget(builder: (context, info) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Text(
              "Sign in",
              style: TextStyle(fontSize: info.screenWidth * 0.04, fontWeight: FontWeight.bold, color: isSignIn ? Colors.black : Colors.grey),
            ),
          ),
          SizedBox(width: info.screenWidth * 0.05),
          GestureDetector(
            onTap: onToggle,
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
