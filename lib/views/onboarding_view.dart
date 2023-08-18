import 'package:flutter/material.dart';

import '../widgets/onboarding_page_view.dart';
import '../widgets/onboarding_stack.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});
  static String id = 'onBoarding';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(stackView: OnboardingPageView()),
    );
  }
}
