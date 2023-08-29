import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/widgets/onboarding_stack.dart';

import '../models/chat_model.dart';
import '../widgets/chatting_page_body.dart';

class MessagesChatView extends StatelessWidget {
  const MessagesChatView({
    super.key,
  });
  static String id = 'messagesChatView';
  @override
  Widget build(BuildContext context) {
    ChatModel? chatModel =
        ModalRoute.of(context)!.settings.arguments as ChatModel;
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(
          stackView: ChattingPageBody(
        chatModel: chatModel,
      )),
    );
  }
}
