import 'package:flutter/material.dart';

class OnboardingStack extends StatelessWidget {
  const OnboardingStack(
      {super.key, required this.stackView, this.isBig = true});

  final Widget stackView;
  final bool isBig;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          child: Image.asset(
            isBig
                ? 'assets/images/Pattern.jpg'
                : 'assets/images/smallpattern.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/images/Gradient.png',
            fit: BoxFit.fill,
          ),
        ),
        stackView,
      ],
    );
  }
}
