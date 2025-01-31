import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/core/theming/colors.dart';
import '../widgets/customButton.dart';
import '../widgets/customTextField.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return Container(

        child: Column(
          spacing: info.screenHeight * 0.022,
          children: [
            CustomTextField(label: "Your Full Name", hintText: "Your name"),
            CustomTextField(label: "Email", hintText: "Type your email"),
            CustomTextField(label: "Phone", hintText: "Type your phone"),
            CustomTextField(label: "Password", hintText: "Type your password", isPassword: true),
            CustomTextField(label: "Confirm Password", hintText: "Retype your password", isPassword: true),

          ],
        ),
      );
    });
  }
}
