import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/features/authentication/presentation/ui/auth_screen/sign_in_screen.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtering_cubit.dart';
import 'package:social_media/features/filtering/presentation/pages/filtering_screen.dart';
import 'package:social_media/features/on_boarding/presentation/ui/onboarding_screen.dart';
import 'package:social_media/features/post_details/presentation/example_screen/ui/postDetailsScreen.dart';
import 'package:social_media/features/splash_screen/presentation/ui/splash_screen.dart';
import '../../features/posts/presentation/homePage/logic/cubit/home_cubit_cubit.dart';
import '../../features/posts/presentation/homePage/ui/homePage_view.dart';
import '../di/di.dart';

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
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<HomeCubit>(),
                  child: HomepageView(),
                ));
      case Routes.filteringScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<FilteringCubit>(),
                  child: FilteringScreen(),
                ));
      case Routes.postDetailsScreen:
        return MaterialPageRoute(builder: (context) => post_details_screen());
      default:
        return null;
    }
  }
}
