import 'package:flutter/material.dart';
import 'package:food/widgets/onboarding_stack.dart';

import '../widgets/login_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static String id = 'loginView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(stackView: LoginBody()),
    );
  }
}
