import 'package:flutter/material.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/features/authentication/presentation/ui/auth_screen/sign_in_screen.dart';
import 'package:social_media/features/filtering/presentation/pages/filtering_screen.dart';
import 'package:social_media/features/on_boarding/presentation/ui/onboarding_screen.dart';
import 'package:social_media/features/splash_screen/presentation/ui/splash_screen.dart';

import '../../features/home/presentation/homePage/ui/homePage_view.dart';

class AppRouts {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case Routes.onBordingScreen:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => SignInForm());
      case Routes.homePage:
        return MaterialPageRoute(builder: (context) => HomepageView());
      case Routes.filteringScreen:
        return MaterialPageRoute(builder: (context) => FilteringScreen());
      default:
        return null;
    }
  }
}
