import 'package:flutter/material.dart';
import 'package:food/widgets/onboarding_stack.dart';

import '../widgets/enter_new_password_body.dart';

class EnterNewPassword extends StatelessWidget {
  const EnterNewPassword({super.key});
  static String id = 'EnterNewPass';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(
        stackView: EnterNewPasswordBody(),
        isBig: false,
      ),
    );
  }
}
