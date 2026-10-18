import 'package:flutter/material.dart';
import 'package:proyecto1/Views/HomeView.dart';
import 'package:proyecto1/Views/LoginView.dart';
import 'package:proyecto1/Views/OnboardigView.dart';
import 'package:proyecto1/Views/RegisterView.dart';
import 'package:proyecto1/Views/SplashView.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PROYECTO 1',
      initialRoute: '/splashview',
      routes: {
        '/splashview': (context) => const SplashView(),
        '/onboardingview': (context) => const OnBoardingView(),
        '/loginview': (context) => LoginView(),
        '/registerview': (context) => RegisterView(),
        '/homeview': (context) => const HomeView(),
      },
    );
  }
}
