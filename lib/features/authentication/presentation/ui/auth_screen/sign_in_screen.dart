import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/core/theming/colors.dart';
import '../widgets/customButton.dart';
import '../widgets/customTextField.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: ColorsManager.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            CustomTextField(label: "E-mail/Phone", hintText: "Email/Phone"),
            CustomTextField(label: "Password", hintText: "Enter password", isPassword: true),
            const SizedBox(height: 20),
            CustomButton(
                text: "Login",
                onPressed: () {
                  context.pushNamed(Routes.homePage);
                }),
          ],
        ),
      );
    });
  }
}
