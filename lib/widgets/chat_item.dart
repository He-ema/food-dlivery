import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../views/chatting_view.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.chatmodel,
    required this.message,
  });

  final ChatModel chatmodel;
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    if (message.time != null) {
      print('===========');
      convertDate(message.time!);
    }
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
              contentPadding: message.messageText == ''
                  ? EdgeInsets.all(15)
                  : EdgeInsets.all(10),
              subtitle: message.messageText == ''
                  ? null
                  : Text(message.messageText,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: message.time == null
                  ? null
                  : Text(convertDate(message.time!)),
            ),
          ),
        ),
      ),
    );
  }

  String convertDate(Timestamp time) {
    var dt = DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);

// 12 Hour format:
    var d12 = DateFormat('hh:mm').format(dt);
    return d12;
  }
}
