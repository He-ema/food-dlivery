import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/views/onboarding_view.dart';

import '../widgets/onboarding_stack.dart';
import '../widgets/splash.dart';

class Splasher extends StatefulWidget {
  const Splasher({super.key});
  static String id = 'Splasher';
  @override
  State<Splasher> createState() => _SplasherState();
}

class _SplasherState extends State<Splasher> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (context) => OnBoarding(),
      ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(stackView: SplashBody()),
    );
  }
}
