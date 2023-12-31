import 'package:food/constants.dart';

class ChatModel {
  final String image;
  final String name;
  final String lastMessage;
  final String date;
  final String email;
  final String token;

  ChatModel({
    required this.image,
    required this.name,
    required this.lastMessage,
    required this.email,
    required this.date,
    required this.token,
  });

  factory ChatModel.fromJson(jsonData) {
    return ChatModel(
      image: jsonData[kImage],
      name: jsonData[kFirstName] + ' ' + jsonData[kSecondName],
      lastMessage: jsonData[kFirstName],
      date: jsonData[kFirstName],
      email: jsonData[kEmail],
      token: jsonData[kToken],
    );
  }
}
