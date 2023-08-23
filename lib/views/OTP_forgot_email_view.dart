import 'package:flutter/material.dart';
import 'package:food/widgets/onboarding_stack.dart';

import '../widgets/OTP_forgotten_email_body.dart';

class OTPForgotEmail extends StatelessWidget {
  const OTPForgotEmail({super.key, this.email});
  final String? email;
  static String id = 'forgottenEmailOTP';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(
        stackView: OTPForgottenEmailBody(email: email),
        isBig: false,
      ),
    );
  }
}
