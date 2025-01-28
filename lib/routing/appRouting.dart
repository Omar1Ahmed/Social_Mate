import 'package:flutter/material.dart';
import 'package:social_media/routing/routs.dart';

import '../MVVM/Views/Home_Screen.dart';
class AppRouts {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homePage:
        return MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home Page'));
      case Routes.onBordingScreen:
        return null;
      default:
        return null;
    }
  }
}
