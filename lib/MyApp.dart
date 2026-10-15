import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto1/Views/LoginView.dart';

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PROYECTO 1',
        home: Loginview(),
    );
  }
}