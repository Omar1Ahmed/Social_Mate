import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_state.dart';
import 'package:social_media/features/authentication/presentation/ui/widgets/customButton.dart';

import '../widgets/customTextField.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextField(
                    label: "E-mail/Phone",
                    hintText: "Email/Phone",
                    controller: context.read<AuthCubit>().emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextField(
                    label: "Password",
                    hintText: "Enter password",
                    isPassword: true,
                    controller: context.read<AuthCubit>().passController,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                //   child: CustomButton(
                //       text: "Login",
                //       onPressed: () {
                //
                //
                //       }),
                // ),
              ],
            );
    });
  }
}
