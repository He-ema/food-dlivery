import 'package:flutter/material.dart';
import 'package:food/widgets/onboarding_stack.dart';

import '../widgets/bottom_sheet_border.dart';
import '../widgets/profile_view.body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(
        stackView: ProfileViewBody(),
        isBig: false,
      ),
    );
  }
}
