import 'package:flutter/material.dart';
import 'package:food/widgets/onboarding_stack.dart';

import '../widgets/info_body.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key});
  static String id = 'InfoView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(
        stackView: InfoViewBody(),
        isBig: false,
      ),
    );
  }
}
