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
                  itemBuilder: (context, index) {
//                     CollectionReference currentChat = FirebaseFirestore.instance
//                         .collection(sortName(
//                             BlocProvider.of<AuthCubit>(context).currentEmail! +
//                                 chatsList[index].email));
//                     List<MessageModel> currentMessage = [];
//                     currentMessage = BlocProvider.of<ChatCubit>(context)
//                         .getLastMessage(currentChat);
//                     String? date;
//                     String? lastmessage;
//                     if (currentMessage.length == 0) {
//                       date = '';
//                       lastmessage = '';
//                     } else {
//                       lastmessage = currentMessage[0].messageText;
// //                       int time = currentMessage[0].time as int ;
// //                       var dt = DateTime.fromMillisecondsSinceEpoch(time);

// // // 12 Hour format:
// //                       var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
//                       date = '';
//                     }
                    return ChatItem(
                      chatmodel: chatsList[index],
                      date: 'date',
                      lastMessge: 'lastmessage',
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

  String sortName(String theRequiredTosort) {
    List<String> charList = theRequiredTosort.split('');
    charList.sort();

    String sortedName = charList.join();
    return sortedName;
  }
}
