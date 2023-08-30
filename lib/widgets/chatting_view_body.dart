import 'package:flutter/material.dart';
import 'package:food/widgets/chat_bubble.dart';
import 'package:food/widgets/custom_icon.dart';
import 'package:food/widgets/custom_text_form_field.dart';

import '../models/chat_model.dart';

class ChattingViewBody extends StatelessWidget {
  const ChattingViewBody({super.key, required this.chatModel});
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomIcon(icon: Icons.arrow_back_ios_new),
              ],
            ),
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
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: ListTile(
                  leading: Image.network(chatModel.image),
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
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => ChatBubble(message: 'message'),
            ))
          ],
        ),
      ),
      Positioned(
        bottom: 5,
        left: 0,
        right: 0,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(boxShadow: [
              // BoxShadow(
              //   blurRadius: 30,
              //   color: Colors.black26,
              // )
            ]),
            child: ClipRRect(
              //borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: buildBorder(Theme.of(context).primaryColor),
                  hintText: 'Enter a message',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: buildBorder(Theme.of(context).primaryColor),
                  focusedBorder: buildBorder(Theme.of(context).primaryColor),
                ),
              ),
            )),
      ),
    ]);
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          width: 2,
          color: color ?? const Color.fromARGB(255, 107, 106, 106),
        ));
  }
}
