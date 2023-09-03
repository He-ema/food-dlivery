import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/cubits/cart_cubit/cart_cubit.dart';
import 'package:food/models/cart_item_model.dart';
import 'package:food/widgets/custom_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BroductBottomSheetBody extends StatefulWidget {
  const BroductBottomSheetBody({
    super.key,
    required this.images,
    required this.description,
    required this.brand,
    required this.image,
    required this.price,
    required this.name,
    required this.id,
    required this.cartItems,
  });
  final List<dynamic> images;
  final List<CartItemModel> cartItems;
  final String image;
  final int price;
  final int id;
  final String name;
  final String description;
  final String brand;
  @override
  State<BroductBottomSheetBody> createState() => _BroductBottomSheetBodyState();
}

class _BroductBottomSheetBodyState extends State<BroductBottomSheetBody> {
  List<Widget> emptyList = [];
  void createItems(List emptyList) {
    for (int i = 0; i < widget.images.length; i++) {
      emptyList.add(Image.network(widget.images[i]));
    }
  }

  int currentIndex = 0;
  bool isAdded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createItems(emptyList);
    for (int i = 0; i < widget.cartItems.length; i++) {
      if (widget.cartItems[i].id == widget.id) {
        isAdded = true;
        break;
      }
    }
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.4,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                    items: emptyList,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 200,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayInterval: Duration(seconds: 3),
                      enableInfiniteScroll: true,
                      aspectRatio: 2,
                      onPageChanged: (index, reason) {
                        setState(() {});
                        currentIndex = index;
                      },
                    )),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Brand : ${widget.brand}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                isAdded
                    ? CustomButton(
                        text: 'Remove from cart',
                        onTap: () async {
                          isLoading = true;
                          setState(() {});
                          await BlocProvider.of<CartCubit>(context)
                              .deleteItem(widget.id);
                          isLoading = false;
                          setState(() {});
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Product removed from cart successfully ',
                                textAlign: TextAlign.center,
                              ),
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              margin: EdgeInsets.only(
                                  bottom: 100, right: 10, left: 10),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                      )
                    : CustomButton(
                        text: 'Add to cart',
                        onTap: () async {
                          isLoading = true;
                          setState(() {});
                          await BlocProvider.of<CartCubit>(context)
                              .addItemToCart(
                                  name: widget.name,
                                  id: widget.id,
                                  quantity: 1,
                                  image: widget.image,
                                  price: widget.price);
                          isLoading = false;
                          setState(() {});
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Product added to cart successfully ',
                                textAlign: TextAlign.center,
                              ),
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              margin: EdgeInsets.only(
                                  bottom: 100, right: 10, left: 10),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                      ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
