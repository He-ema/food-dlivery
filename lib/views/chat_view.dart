import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/chat_cubit/chat_cubit.dart';
import 'package:food/widgets/onboarding_stack.dart';

import '../widgets/chat_view_body.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnboardingStack(
        stackView: ChatViewBody(),
        isBig: false,
      ),
    );
  }
}
