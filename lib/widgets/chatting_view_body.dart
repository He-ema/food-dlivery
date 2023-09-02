import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/constants.dart';
import 'package:food/cubits/auth_cubit/auth_cubit_cubit.dart';
import 'package:food/cubits/chat_cubit/chat_cubit.dart';
import 'package:food/widgets/chat_bubble.dart';
import 'package:food/widgets/custom_icon.dart';

import '../helpers/sort.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChattingViewBody extends StatefulWidget {
  const ChattingViewBody({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<ChattingViewBody> createState() => _ChattingViewBodyState();
}

class _ChattingViewBodyState extends State<ChattingViewBody> {
  CollectionReference? currentChat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentChat = FirebaseFirestore.instance.collection(sort().sortName(
        BlocProvider.of<AuthCubit>(context).currentEmail! +
            widget.chatModel.email));
    BlocProvider.of<ChatCubit>(context).getMessages(currentChat!);
  }

  final TextEditingController _controller = TextEditingController();
  final ScrollController _controller2 = ScrollController();

  List<MessageModel> messagesList = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        messagesList = BlocProvider.of<ChatCubit>(context).messagesList;
      },
      builder: (context, state) {
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
                    CustomIcon(
                        icon: Icons.arrow_back_ios_new,
                        onTap: () async {
                          Navigator.pop(context);
                          await BlocProvider.of<ChatCubit>(context).getChats();
                        }),
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
                      leading: Image.network(widget.chatModel.image),
                      title: Text(
                        widget.chatModel.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
                  reverse: true,
                  controller: _controller2,
                  padding: EdgeInsets.zero,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) => messagesList[index].sender ==
                          BlocProvider.of<AuthCubit>(context).currentEmail
                      ? ChatBubble(message: messagesList[index])
                      : ChatBubbleForFriend(message: messagesList[index]),
                )),
                SizedBox(
                  height: 60,
                ),
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
                    controller: _controller,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (_controller.text != ' ' &&
                              _controller.text != '') {
                            currentChat!.add({
                              kTime: DateTime.now(),
                              kSender: BlocProvider.of<AuthCubit>(context)
                                  .currentEmail!,
                              kMessage: _controller.text,
                            });
                            _controller.clear();
                            BlocProvider.of<ChatCubit>(context)
                                .sendNotification(
                                    title: widget.chatModel.name,
                                    body: _controller.text,
                                    token: widget.chatModel.token);
                          }
                          _controller2.animateTo(
                            _controller2.position.minScrollExtent,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        child: Icon(
                          Icons.send,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: buildBorder(Theme.of(context).primaryColor),
                      hintText: 'Enter a message',
                      hintStyle: const TextStyle(color: Colors.grey),
                      enabledBorder:
                          buildBorder(Theme.of(context).primaryColor),
                      focusedBorder:
                          buildBorder(Theme.of(context).primaryColor),
                    ),
                  ),
                )),
          ),
        ]);
      },
    );
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
