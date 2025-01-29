import 'package:flutter/material.dart';
import 'package:social_media/MVVM/Views/Screens/onBoarding_screen/onboarding_screen.dart';
import 'package:social_media/MVVM/Views/Screens/splash_screen/splash_screen.dart';
import 'package:social_media/routing/routs.dart';

import '../MVVM/Views/Screens/auth_screens/sign_in_screen.dart';
import '../MVVM/Views/Screens/homePage_screen/homePage_view.dart';

class AppRouts {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case Routes.homePage:
        return MaterialPageRoute(builder: (context) => HomepageView());
      case Routes.onBordingScreen:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => SignInForm());
      default:
        return null;
    }
  }
}
