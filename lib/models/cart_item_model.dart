import 'package:food/constants.dart';

class CartItemModel {
  final String image;
  final int quantity;
  final int price;
  final int id;
  final String name;

  CartItemModel(
      {required this.image,
      required this.quantity,
      required this.id,
      required this.price,
      required this.name});

  factory CartItemModel.fromJson(jsonData) {
    return CartItemModel(
        image: jsonData[kImage],
        quantity: jsonData[kQuantity],
        price: jsonData[kPrice],
        id: jsonData[kId],
        name: jsonData[KName]);
  }
}
