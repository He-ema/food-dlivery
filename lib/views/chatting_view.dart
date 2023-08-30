import 'package:flutter/material.dart';
import 'package:food/widgets/onboarding_stack.dart';

import '../models/chat_model.dart';
import '../widgets/chatting_view_body.dart';

class ChattingView extends StatelessWidget {
  const ChattingView({super.key, required this.chatmodel});
  final ChatModel chatmodel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(
          stackView: ChattingViewBody(
        chatModel: chatmodel,
      )),
    );
  }
}
