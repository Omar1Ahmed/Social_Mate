import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/SharedPref/SharedPrefKeys.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/features/posts/presentation/homePage/logic/cubit/home_cubit_cubit.dart';
import 'package:social_media/features/posts/presentation/homePage/ui/homePage_view.dart';
import '../../../on_boarding/presentation/ui/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
             getIt<userMainDetailsCubit>().getToken();
            final tokenFromCubit =
                context.read<userMainDetailsCubit>().state.token;
            print('token from cubit: $tokenFromCubit');
            if (tokenFromCubit != null) {
              Future.delayed(Duration(seconds: 3));
              return BlocProvider(
                create: (context) => getIt<HomeCubit>(),
                child: HomepageView(),
              );
            } else {
              print('going to onboarding');
              return OnboardingScreen();
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation, // Fade animation
              child: child,
            );
          },
          transitionDuration:
              const Duration(milliseconds: 1000), // Adjust the duration
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
