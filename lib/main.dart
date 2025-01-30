import 'package:flutter/material.dart';

import 'core/routing/appRouting.dart';


void main() {
  runApp(MyApp(
    appRouter: AppRouts(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouts appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: Routes.splashScreen,
      // onGenerateRoute: appRouter.generateRoute,
    );
  }
}
