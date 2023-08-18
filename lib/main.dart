import 'package:flutter/material.dart';
import 'package:food/constants.dart';
import 'package:food/views/onboarding_view.dart';
import 'package:food/views/register_view.dart';
import 'package:food/views/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: KprimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        Splasher.id: (context) => Splasher(),
        RegisterView.id: (context) => RegisterView(),
        OnBoarding.id: (context) => OnBoarding(),
      },
      initialRoute: Splasher.id,
    );
  }
}
