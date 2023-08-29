import 'package:flutter/material.dart';
import 'package:food/widgets/custom_icon.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          SizedBox(
            height: 55,
          ),
          CustomIcon(icon: Icons.arrow_back_ios_new_outlined),
          SizedBox(
            height: 16,
          ),
          Text(
            'Chat',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
