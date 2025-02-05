import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_state.dart';
import 'package:social_media/features/authentication/presentation/ui/widgets/customButton.dart';

import '../widgets/customTextField.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return InfoWidget(builder: (context, info) {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthLogInErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is AuthLogInTokenRetrivedState ||
              state is AuthSignInState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextField(
                    label: "E-mail/Phone",
                    hintText: "Email/Phone",
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextField(
                    label: "Password",
                    hintText: "Enter password",
                    isPassword: true,
                    controller: passwordController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomButton(
                      text: "Login",
                      onPressed: () {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          context.read<AuthCubit>().logIn(
                              emailController.text, passwordController.text);
                          Navigator.pushNamed(context, Routes.homePage);
                        } else {
                          print(emailController.text);
                          print(passwordController.text);
                          Navigator.pushNamed(context, Routes.homePage);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(
                          //       'Invalid Input , try again',
                          //       style: TextStyle(color: Colors.white),
                          //     ),
                          //     backgroundColor: Colors.red,
                          //     duration: Duration(seconds: 2),
                          //   ),
                          // );
                        }
                      }),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('unknown state'),
            );
          }
        },
      );
    });
  }
}
