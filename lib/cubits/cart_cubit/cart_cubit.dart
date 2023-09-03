import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/constants.dart';
import 'package:food/models/product_model.dart';
import 'package:meta/meta.dart';

import '../../models/cart_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  List<CartItemModel> cartItems = [];
  CollectionReference cart =
      FirebaseFirestore.instance.collection(kCartCollectionReference);
  Future<void> addItemToCart({
    required String name,
    required int quantity,
    required String image,
    required int price,
    required int id,
  }) async {
    emit(CartLoading());
    try {
      await cart.doc(id.toString()).set({
        KName: name,
        kQuantity: quantity,
        kImage: image,
        kPrice: price,
        kId: id,
        kTime: DateTime.now(),
      });
      emit(CartSuccess());
    } catch (e) {
      emit(CartFailure());
    }
  }

  void getCartItems() {
    cart.orderBy(kTime, descending: true).snapshots().listen((event) {
      cartItems.clear();

      for (var doc in event.docs) {
        cartItems.add(CartItemModel.fromJson(doc));
      }

      emit(CartSuccess());
    });
  }

  Future<void> deleteItem(int id) async {
    emit(CartLoading());
    try {
      await cart.doc(id.toString()).delete();
      emit(CartSuccess());
    } catch (e) {
      emit(CartFailure());
    }
  }
}
