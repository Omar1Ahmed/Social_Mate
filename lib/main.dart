import 'package:flutter/material.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/routing/routs.dart';

import 'core/routing/appRouting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(MyApp(appRouter: AppRouts()));
}

class MyApp extends StatelessWidget {
  final AppRouts appRouter;
  const MyApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
