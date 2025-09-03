import 'package:flutter/material.dart';
import 'package:gowatch/features/movie/views/view/home_page.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 
          Center(
            child: Lottie.asset( 
              'assets/Animation - 1746290710872.json',
            ),
          ),
       
      nextScreen: HomePage(),
      duration: 3500,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
      splashIconSize: 400,
    );
  }
}