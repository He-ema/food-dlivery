import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.chatmodel,
  });
  final ChatModel chatmodel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: Colors.grey,
                spreadRadius: 2,
                offset: Offset(2, 2),
              )
            ]),
        child: ListTile(
          leading: chatmodel.image == null
              ? Image.asset('assets/images/avatar.png')
              : Image.network(chatmodel.image!),
          title: Text(chatmodel.name),
          subtitle: Text(chatmodel.lastMessage),
          trailing: Text(chatmodel.Date),
        ),
      ),
    );
  }
}
