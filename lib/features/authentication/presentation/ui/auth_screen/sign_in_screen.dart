import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_cubit.dart';

import '../widgets/customTextField.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return  Container(
        margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.056),
        child: Column(
          spacing: info.screenHeight * 0.031,
          children: [

            CustomTextField(
              label: "E-mail/Phone",
              hintText: "Email/Phone",
              controller: context.read<AuthCubit>().emailController,
            ),

            CustomTextField(
              label: "Password",
              hintText: "Enter password",
              isPassword: true,
              controller: context.read<AuthCubit>().passController,
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
        ),
      );
    });
  }
}
