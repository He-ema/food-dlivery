import 'package:flutter/material.dart';
import 'package:food/widgets/onboarding_stack.dart';

import '../widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(
        stackView: CartViewBody(),
        isBig: false,
      ),
    );
  }
}
