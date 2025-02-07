import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import '../../../on_boarding/presentation/ui/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation, // Fade animation
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 1000), // Adjust the duration
        ),
      );


    });

    return InfoWidget(builder: (context, deviceInfo) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash_screen.png',
                width: deviceInfo.screenWidth * 0.7,
                height: deviceInfo.screenHeight * 0.4,
              ),
              Image.asset(
                'assets/images/fullLogo.png',
                width: deviceInfo.screenWidth * 0.7,
                height: deviceInfo.screenHeight * 0.16,
              ),
            ],
          ),
        ),
      );
    });
  }
}
