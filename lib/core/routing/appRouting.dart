import 'package:flutter/material.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/features/authentication/presentation/example_screen/ui/sign_in_screen.dart';
import 'package:social_media/features/on_boarding/presentation/example_screen/ui/onboarding_screen.dart';
import 'package:social_media/features/splash_screen/presentation/example_screen/ui/splash_screen.dart';

class AppRouts {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case Routes.onBordingScreen:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => SignInForm());
      default:
        return null;
    }
  }
}
