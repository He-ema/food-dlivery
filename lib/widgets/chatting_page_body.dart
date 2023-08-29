import 'package:flutter/material.dart';
import 'package:food/widgets/custom_icon.dart';

import '../models/chat_model.dart';

class ChattingPageBody extends StatelessWidget {
  const ChattingPageBody({super.key, required this.chatModel});
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        CustomIcon(icon: Icons.arrow_back_ios_new),
        SizedBox(
          height: 12,
        ),
        Container(
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
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: ListTile(
              leading: chatModel.image == null
                  ? Image.asset('assets/images/avatar.png')
                  : Image.network(chatModel.image!),
              title: Text(
                chatModel.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.call,
                    color: Colors.blue,
                  )),
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => Container(),
        )),
      ],
    );
  }
}
