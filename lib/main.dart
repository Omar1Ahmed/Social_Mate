import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/routing/routs.dart';

import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_cubit.dart';

import 'core/routing/appRouting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initDependencies();
  runApp(
    MyApp(
      appRouter: AppRouts(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouts appRouter;
  const MyApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent to show SafeArea effect
      statusBarIconBrightness: Brightness.dark, // Use Brightness.light for white icons
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider<userMainDetailsCubit>(
          create: (context) => getIt<userMainDetailsCubit>(),
        ),

        // here is the token cubit made by omar -------------------
        // BlocProvider<TokenCubit>(
        //   create: (context) => getIt<TokenCubit>(),
        //),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.adminReportScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
