import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/features/admin/presentation/all_reports/ui/pages/reports_home_screen.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:social_media/features/authentication/presentation/ui/auth_screen/auth_screen.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtered_users/filtered_users_cubit.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtering_cubit.dart';
import 'package:social_media/features/filtering/presentation/cubit/sharing_data/sharing_data_cubit.dart';
import 'package:social_media/features/filtering/presentation/pages/filtering_screen.dart';
import 'package:social_media/features/on_boarding/presentation/ui/onboarding_screen.dart';
import 'package:social_media/features/posts/presentation/postDetails/presentation/logic/post_details_cubit.dart';
import 'package:social_media/features/posts/presentation/postDetails/presentation/ui/postDetailsScreen.dart';
import 'package:social_media/features/splash_screen/presentation/ui/splash_screen.dart';
import '../../features/admin/presentation/report_details/ui/report_detials_screen.dart';
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
      case Routes.AuthScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => getIt<AuthCubit>(), child: AuthScreen()));
      case Routes.homePage:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<HomeCubit>(),
                  child: HomepageView(),
                ));
      case Routes.filteringScreen:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<FilteringCubit>(
                    create: (context) => getIt<FilteringCubit>(),
                  ),
                  BlocProvider<SharingDataCubit>(
                    create: (context) => SharingDataCubit(),
                  ),
                  BlocProvider<HomeCubit>(
                      create: (context) => getIt<HomeCubit>()),
                  BlocProvider<FilteredUsersCubit>(
                    create: (context) => getIt<FilteredUsersCubit>(),
                  )
                ], child: FilteringScreen()));
      case Routes.postDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<PostDetailsCubit>(),
            child: post_details_screen(),
          ),
        );
      case Routes.adminReportScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<PostDetailsCubit>(),
                  child: ReportDetailsScreen(),
                ));
      case Routes.reportsHomeScreen:
        return MaterialPageRoute(builder: (context) => ReportsHomeScreen());
      default:
        return null;
    }
  }
}
