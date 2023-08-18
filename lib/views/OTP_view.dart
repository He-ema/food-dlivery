import 'package:flutter/material.dart';
import 'package:food/widgets/onboarding_stack.dart';

import '../widgets/OTP_body.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key});
  static String id = 'OTP';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(stackView: OTPViewBody(), isBig: false),
    );
  }
}
