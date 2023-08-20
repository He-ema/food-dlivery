import 'package:flutter/material.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:food/widgets/onboarding_stack.dart';

class Congratulations extends StatelessWidget {
  const Congratulations({super.key, required this.text, this.onTap});

  final Text text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return OnboardingStack(
        stackView: Center(
      child: Column(
        children: [
          SizedBox(
            height: 170,
          ),
          Image.asset('assets/images/Congratulations.png'),
          SizedBox(
            height: 12,
          ),
          Text(
            'Congrats!',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12,
          ),
          text,
          Spacer(),
          CustomButton(
            text: 'Finish',
            onTap: onTap,
          )
        ],
      ),
    ));
  }
}
