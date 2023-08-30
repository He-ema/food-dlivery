import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/chat_cubit/chat_cubit.dart';

import '../models/chat_model.dart';
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
                  itemCount: chatsList.length,
                  itemBuilder: (context, index) =>
                      ChatItem(chatmodel: chatsList[index]),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
