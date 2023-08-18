import 'package:flutter/material.dart';

class OnboardingStack extends StatelessWidget {
  const OnboardingStack(
      {super.key, required this.stackView, this.isBig = true});

  final Widget stackView;
  final bool isBig;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            isBig
                ? 'assets/images/Pattern.jpg'
                : 'assets/images/smallpattern.png',
            fit: BoxFit.fitWidth,
          ),
        ]),
        Image.asset('assets/images/Gradient.png'),
        stackView,
      ],
    );
  }
}
