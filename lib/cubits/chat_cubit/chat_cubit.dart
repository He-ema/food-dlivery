import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/models/chat_model.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';
import '../../models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<ChatModel> usersList = [];
  List<MessageModel> messagesList = [];
  CollectionReference users =
      FirebaseFirestore.instance.collection(kUseresCollectionReference);
  void getChats() {
    users.snapshots().listen((event) {
      usersList.clear();
      for (var doc in event.docs) {
        print(doc.id);
        usersList.add(ChatModel.fromJson(doc));
      }
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
}
