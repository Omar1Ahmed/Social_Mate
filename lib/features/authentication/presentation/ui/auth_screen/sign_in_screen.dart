import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/FormValidator/Validator.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_cubit.dart';

import '../../../../../core/theming/colors.dart';
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
      return Container(
        margin: EdgeInsetsDirectional.only(top: info.screenHeight * 0.056),
        child: Column(
          children: [
            CustomTextField(
              label: "E-mail",
              hintText: "Email",
              controller: context.read<AuthCubit>().emailController,
              formValidator: ValidatorHelper.combineValidators([
                ValidatorHelper.isNotEmpty,
                ValidatorHelper.isValidEmail,
              ]),
            ),
            SizedBox(
              height: info.screenHeight * 0.015,
            ),
            CustomTextField(
              label: "Password",
              hintText: "Enter password",
              isPassword: true,
              controller: context.read<AuthCubit>().passController,
            ),
            SizedBox(
              height: info.screenHeight * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  
                  value: context.read<AuthCubit>().isRememberMe,
                  onChanged: (value) {
                    context.read<AuthCubit>().isRememberMe = value!;
                  },
                ),
                Text('Remember Me'),
              ],
            ),
          ],
        ),
      );
    });
  }
}
