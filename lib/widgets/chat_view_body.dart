import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/auth_cubit/auth_cubit_cubit.dart';
import 'package:food/cubits/chat_cubit/chat_cubit.dart';
import 'package:food/models/message_model.dart';

import '../models/chat_model.dart';
import 'chat_item.dart';

class ChatViewBody extends StatefulWidget {
  ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  List<ChatModel> chatsList = [];
  List<MessageModel> messagesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBlocChats();
  }

  void getBlocChats() async {
    await BlocProvider.of<ChatCubit>(context).getChats();
  }

  int length = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        chatsList = BlocProvider.of<ChatCubit>(context).usersList;
        messagesList =
            BlocProvider.of<ChatCubit>(context).permenanetMessagesList;

        length = messagesList.length;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(
                height: 55,
              ),
              Text(
                'Chats',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: length,
                  itemBuilder: (context, index) {
                    return ChatItem(
                      chatmodel: chatsList[index],
                      message: messagesList[index],
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
