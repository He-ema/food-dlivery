import 'package:flutter/material.dart';
import 'package:food/widgets/enter_forgotten_email_body.dart';
import 'package:food/widgets/onboarding_stack.dart';

class EnterForgottenEmail extends StatelessWidget {
  const EnterForgottenEmail({super.key});
  static String id = 'ForgottenEmail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(
        stackView: EnterForgottenEmailBody(),
        isBig: false,
      ),
    );
  }
}
