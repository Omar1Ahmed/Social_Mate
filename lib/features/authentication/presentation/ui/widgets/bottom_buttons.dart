import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/features/authentication/presentation/ui/auth_screen/auth_screen.dart';
class BottomButtons extends StatelessWidget {
  final VoidCallback onNext;

  const BottomButtons({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return Padding(
        padding:  EdgeInsets.symmetric(horizontal: info.screenWidth * 0.08),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(info.screenWidth * 0.04),
                ),
                minimumSize:  Size(double.infinity, info.screenHeight * 0.057),
              ),
              child: Text(
                "Join Now",
                style: TextStyle(color: Colors.white,fontSize: info.screenWidth * 0.041, fontWeight: FontWeight.bold),
              ),
            ),
             SizedBox(height: info.screenHeight * 0.015),
            TextButton(
              onPressed: () {
                // Navigate to Login
                Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()
                ));
              },
              child:  Text(
                "Sign In",
                style: TextStyle(

                  fontSize: info.screenWidth * 0.04,
                  color: ColorsManager.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    });
    }}
