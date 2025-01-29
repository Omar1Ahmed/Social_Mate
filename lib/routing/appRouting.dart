import 'package:flutter/material.dart';
import 'package:social_media/MVVM/Views/Screens/onboarding_screen.dart';
import 'package:social_media/MVVM/Views/Screens/splash_screen.dart';
import 'package:social_media/routing/routs.dart';

import '../MVVM/Views/Home_Screen.dart';
class AppRouts {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) =>SplashScreen());

      case Routes.homePage:
        return MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home Page'));
      case Routes.onBordingScreen:
        return MaterialPageRoute(builder: (context) =>OnboardingScreen());
      default:
        return null;
    }
  }
}
