import 'package:flutter/material.dart';
import 'package:food/widgets/custom_icon.dart';
import 'package:food/widgets/custom_text_form_field.dart';

import 'auto_slidable_cards.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 65,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Find Your\nFavourite Food',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Stack(
                children: [
                  CustomIcon(
                    onTap: () {},
                    icon: Icons.notifications_none,
                  ),
                  Positioned(
                    top: 10,
                    right: 12,
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.red,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: CustomTextFormField(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    hint: 'What do you want to order ?',
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                  )),
              CustomIcon(
                icon: Icons.format_list_bulleted_rounded,
                onTap: () {},
              )
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        AutoSlidableCards(),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [],
          ),
        ),
      ],
    );
  }
}
