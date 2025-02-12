import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:device_preview/device_preview.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'core/routing/appRouting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initDependencies();

  // Run the app with DevicePreview enabled
  runApp(
    MyApp(
        appRouter: AppRouts(),
    ),
  );

  // runApp(
  //   DevicePreview(
  //     // Wrap the app with DevicePreview
  //     enabled: !bool.fromEnvironment('dart.vm.product'), // Disable in release mode
  //     builder: (context) => MyApp(
  //       appRouter: AppRouts(),
  //     ),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  final AppRouts appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return BlocProvider<userMainDetailsCubit>(
      create: (context) => getIt<userMainDetailsCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: appRouter.generateRoute,
        builder: DevicePreview.appBuilder, 
      ),
    );
  }
}
