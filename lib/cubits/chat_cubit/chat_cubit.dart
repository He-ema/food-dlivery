import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/models/chat_model.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';
import '../../helpers/sort.dart';
import '../../models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  String? currentEmail;
  List<ChatModel> usersList = [];
  List<MessageModel> messagesList = [];
  List<MessageModel> temporaryMessagesList = [];
  List<MessageModel> permenanetMessagesList = [];

  CollectionReference users =
      FirebaseFirestore.instance.collection(kUseresCollectionReference);
  Future<void> getChats() async {
    users.snapshots().listen((event) async {
      usersList.clear();
      int index = 0;
      permenanetMessagesList.clear();
      for (var doc in event.docs) {
        usersList.add(ChatModel.fromJson(doc));
        CollectionReference currentChat = FirebaseFirestore.instance.collection(
            sort().sortName(currentEmail! + usersList[index].email));

        String currentChatAsString =
            sort().sortName(currentEmail! + usersList[index].email);
        await getLastMessage(
            collection: currentChat, collectionAsString: currentChatAsString);

        index++;
        // print('===========================================');
        // print('$index message is ');
        // print(permenanetMessagesList[index].messageText);
        // print('===========================================');
      }
      print('the length');
      print(permenanetMessagesList.length);
      emit(ChatSuccess());
    });
  }

  void getMessages(CollectionReference collection) {
    collection.orderBy(kTime, descending: true).snapshots().listen((event) {
      messagesList.clear();

      for (var doc in event.docs) {
        messagesList.add(MessageModel.fromJson(doc));
      }

      emit(ChatSuccess());
    });
  }

  Future<void> getLastMessage(
      {required CollectionReference collection,
      required String collectionAsString}) async {
    temporaryMessagesList.clear();
    var temp = await FirebaseFirestore.instance
        .collection(collectionAsString)
        .orderBy(kTime, descending: true)
        .get();
    if (temp.docs.length == 0) {
      permenanetMessagesList
          .add(MessageModel(messageText: '', sender: '', time: null));
    } else {
      for (final documents in temp.docs) {
        permenanetMessagesList.add(MessageModel.fromJson(documents));
        break;
      }
    }
    emit(ChatSuccess());
  }
}
