import 'package:flutter/material.dart';

class OnboardingStack extends StatelessWidget {
  const OnboardingStack({super.key, required this.stackView});

  final Widget stackView;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/images/Pattern.jpg',
            fit: BoxFit.fitWidth,
          ),
        ]),
        Image.asset('assets/images/Gradient.png'),
        stackView,
      ],
    );
  }
}
