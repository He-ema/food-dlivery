import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/constants.dart';

class MessageModel {
  final String messageText;
  final String sender;
  final Timestamp? time;

  MessageModel(
      {required this.messageText, required this.sender, required this.time});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
        messageText: jsonData[kMessage],
        sender: jsonData[kSender],
        time: jsonData[kTime]);
  }
}
