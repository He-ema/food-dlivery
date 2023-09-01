import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../views/chatting_view.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.chatmodel,
    required this.date,
    required this.lastMessge,
  });
  final String date;
  final String lastMessge;
  final ChatModel chatmodel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ChattingView(
              chatmodel: chatmodel,
            );
          }));
        },
        child: AbsorbPointer(
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
              leading: Image.network(chatmodel.image),
              title: Text(
                chatmodel.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              contentPadding: EdgeInsets.all(10),
              subtitle: Text(lastMessge,
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: Text(date),
            ),
          ),
        ),
      ),
    );
  }
}
