import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/cart_cubit/cart_cubit.dart';
import 'package:food/widgets/cart_item.dart';
import 'package:food/widgets/custom_button.dart';
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
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Lottie.asset('assets/images/empty.json'),
                Text(
                  'Cart is Empty',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]));
        } else {
          int total = 0;
          for (int i = 0; i < cartItems.length; i++) {
            total += (cartItems[i].price * cartItems[i].quantity);
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                Column(
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
                          return Dismissible(
                            onDismissed: (direction) {
                              setState(() {});
                            },
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                await BlocProvider.of<CartCubit>(context)
                                    .deleteItem(cartItems[index].id);
                              }
                              if (direction == DismissDirection.startToEnd) {
                                await BlocProvider.of<CartCubit>(context)
                                    .deleteItem(cartItems[index].id);
                              }
                            },
                            key: ValueKey<CartItemModel>(cartItems[index]),
                            background: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        size: 40,
                                        Icons.delete,
                                      ),
                                      Icon(
                                        size: 40,
                                        Icons.delete,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            child: CartItem(
                              AddOnTap: () async {
                                await BlocProvider.of<CartCubit>(context)
                                    .increaseQuantity(cartItems[index].id,
                                        cartItems[index].quantity);
                                setState(() {});
                              },
                              minusOnTap: () async {
                                await BlocProvider.of<CartCubit>(context)
                                    .decreaseQuantity(cartItems[index].id,
                                        cartItems[index].quantity);
                                setState(() {});
                                if (cartItems[index].quantity == 0) {
                                  await BlocProvider.of<CartCubit>(context)
                                      .deleteItem(cartItems[index].id);
                                  setState(() {});
                                }
                              },
                              name: cartItems[index].name,
                              price: cartItems[index].price,
                              quantity: cartItems[index].quantity,
                              image: cartItems[index].image,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Pattern (3).png'),
                            fit: BoxFit.cover),
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                ' sub total  : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                '\$' '$total',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Delivery   : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                '\$10 ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Discount : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                '\$20 ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Total : ${total + 30}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          CustomButton(
                            color: Colors.white,
                            text: 'Confirm',
                            alternativeText: Text(
                              'Confirm',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          );
        }
      },
    );
  }
}
