import 'package:flutter/material.dart';
import 'package:social_media/routing/appRouting.dart';

import 'routing/routs.dart';

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
      initialRoute: Routes.homePage,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
