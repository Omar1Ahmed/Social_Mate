import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_media/MVVM/Views/Screens/onboarding_screen.dart';
import 'package:social_media/Responsive/ui_component/info_widget.dart';

import '../../../theming/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context,info)
    {
      return Scaffold(

        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:ColorsManager.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/splash_screen.png", height: 350),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  //assets/images/fullLogo.png
                  child: Image.asset("assets/images/fullLogo.png",),
                ),
              ],
            ),
          ),
        ),
      );
     });
  }
}




