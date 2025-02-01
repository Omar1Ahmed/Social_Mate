import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';

import '../widgets/customTextField.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return Column(
        children: [
      
          SizedBox(height: info.screenHeight * 0.065),
          CustomTextField(label: "E-mail/Phone", hintText: "Email/Phone"),
          SizedBox(height: info.screenHeight * 0.035),
          CustomTextField(label: "Password", hintText: "Enter password", isPassword: true),
      
        //   CustomButton(
        //       text: "Login",
        //       onPressed: () {
        //         context.pushNamed(Routes.homePage);
        //       }),
        ],
      );
    });
  }
}
