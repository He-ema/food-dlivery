import 'package:flutter/material.dart';
import 'package:food/widgets/onboarding_stack.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(
        stackView: Container(),
        isBig: false,
      ),
    );
  }
}
