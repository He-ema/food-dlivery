import 'package:food/constants.dart';

class ChatModel {
  final String image;
  final String name;
  final String lastMessage;
  final String Date;
  final String email;

  ChatModel(
      {required this.image,
      required this.name,
      required this.lastMessage,
      required this.email,
      required this.Date});

  factory ChatModel.fromJson(jsonData) {
    return ChatModel(
      image: jsonData[kImage],
      name: jsonData[kFirstName] + ' ' + jsonData[kSecondName],
      lastMessage: jsonData[kFirstName],
      Date: jsonData[kFirstName],
      email: jsonData[kEmail],
    );
  }
}
