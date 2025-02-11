import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:device_preview/device_preview.dart'; // Import the package
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_cubit.dart';
import 'core/routing/appRouting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initDependencies();

  // Run the app with DevicePreview enabled
  runApp(
    DevicePreview(
      // Wrap the app with DevicePreview
      enabled: !bool.fromEnvironment('dart.vm.product'), // Disable in release mode
      builder: (context) => MyApp(
        appRouter: AppRouts(),
      ),
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
        // Uncomment if you want to include the TokenCubit
        // BlocProvider<TokenCubit>(
        //   create: (context) => getIt<TokenCubit>(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: appRouter.generateRoute,
        builder: DevicePreview.appBuilder, // Use the builder provided by DevicePreview
      ),
    );
  }
}
