import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/chat_cubit/chat_cubit.dart';
import 'package:food/widgets/custom_icon.dart';

import '../models/chat_model.dart';
import '../views/messages_chat_view.dart';
import 'chat_item.dart';

class ChatViewBody extends StatefulWidget {
  ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  List<ChatModel> chatsList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ChatCubit>(context).getChats();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        chatsList = BlocProvider.of<ChatCubit>(context).usersList;
      },
      builder: (context, state) {
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
              Expanded(
                child: ListView.builder(
                  itemCount: chatsList.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, MessagesChatView.id,
                            arguments: chatsList[index]);
                      },
                      child: ChatItem(chatmodel: chatsList[index])),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
