import 'package:flutter/material.dart';
import 'package:social_media/MVVM/Views/Screens/homePage_screen/homePage_view.dart';
import 'package:social_media/Responsive/ui_component/info_widget.dart';
import 'package:social_media/helper/extantions.dart';
import 'package:social_media/routing/routs.dart';
import '../../../../theming/colors.dart';
import 'widgets/customButton.dart';
import 'widgets/customTextField.dart';

class SignUpForm extends StatelessWidget {
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
            CustomTextField(label: "Your Full Name", hintText: "Your name"),
            CustomTextField(label: "Email", hintText: "Type your email"),
            CustomTextField(label: "Phone", hintText: "Type your phone"),
            CustomTextField(label: "Password", hintText: "Type your password", isPassword: true),
            CustomTextField(label: "Confirm Password", hintText: "Retype your password", isPassword: true),
            const SizedBox(height: 20),
            CustomButton(
                text: "Join Now",
                onPressed: () {
                  context.pushNamed(Routes.homePage);
                }),
          ],
        ),
      );
    });
  }
}
