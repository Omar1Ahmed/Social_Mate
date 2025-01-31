import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import '../../../../../core/routing/routs.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.onBordingScreen);
      FlutterNativeSplash.remove();

    });

    return InfoWidget(builder: (context, info) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: info.screenHeight * 0.01,
            children: [

              Image.asset("assets/images/splash_screen.png", height: 350 ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: info.screenWidth * 0.1),
                child: Image.asset("assets/images/fullLogo.png"),
              ),
            ],
          ),
        ),
      );
    });
  }
}