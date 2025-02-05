import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';

import 'core/routing/appRouting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
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
    return BlocProvider(
        create: (_) => getIt<userMainDetailsCubit>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splashScreen,
          onGenerateRoute: appRouter.generateRoute,
        ));
  }
}
