import 'package:flutter/material.dart';
import 'package:social_media/MVVM/Views/Screens/member_and_admin_view.dart';
import 'package:social_media/Responsive/ui_component/info_widget.dart';
import '../../../theming/colors.dart';
import '../ReusableWidgets/customButton.dart';
import '../ReusableWidgets/customTextField.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context,info)
    {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:ColorsManager.gradientColors,
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
            CustomButton(text: "Join Now", onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemberAndAdminView()),
              );
            }),
          ],
        ),
      );
    }

    );
  }
}
