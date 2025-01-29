import 'package:flutter/material.dart';
import 'package:social_media/routing/routs.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.onBordingScreen);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset("assets/images/splash_screen.png", height: 350),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Image.asset("assets/images/fullLogo.png"),
            ),
          ],
        ),
      ),
    );
  }
}