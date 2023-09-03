import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/cart_cubit/cart_cubit.dart';
import 'package:food/widgets/cart_item.dart';
import 'package:lottie/lottie.dart';

import '../models/cart_item_model.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CartCubit>(context).getCartItems();
  }

  List<CartItemModel> cartItems = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        cartItems = BlocProvider.of<CartCubit>(context).cartItems;
      },
      builder: (context, state) {
        if (cartItems.isEmpty) {
          return Center(child: Lottie.asset('assets/images/empty.json'));
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 75,
                ),
                Text(
                  'Cart',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        name: cartItems[index].name,
                        price: cartItems[index].price,
                        quantity: cartItems[index].quantity,
                        image: cartItems[index].image,
                      );
                    },
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
