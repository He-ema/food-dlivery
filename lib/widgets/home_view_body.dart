import 'package:flutter/material.dart';

import 'auto_slidable_cards.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutoSlidableCards(),
      ],
    );
  }
}
