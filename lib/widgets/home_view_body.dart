import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food/models/product_model.dart';
import 'package:food/services/get_product_service.dart';
import 'package:food/widgets/widgets_above_slider.dart';

import '../cubits/cart_cubit/cart_cubit.dart';
import '../models/cart_item_model.dart';
import 'auto_slidable_cards.dart';
import 'grid_item.dart';

class HomeViewBody extends StatefulWidget {
  HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  bool hasAccess = true;
  bool hasScrolled = true;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CartCubit>(context).getCartItems();
  }

  List<CartItemModel> cartItems = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: AllProductService().getAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          cartItems = BlocProvider.of<CartCubit>(context).cartItems;
          List<ProductModel> products = snapshot.data!;
          return Column(
            children: [
              WidgetsAboveSlider(),
              SizedBox(
                height: 12,
              ),
              Visibility(
                  maintainState: true,
                  maintainAnimation: true,
                  visible: hasScrolled,
                  child: AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    onEnd: () {
                      hasScrolled = hasAccess;
                      setState(() {});
                    },
                    curve: Curves.fastOutSlowIn,
                    opacity: hasAccess ? 1 : 0,
                    child: AutoSlidableCards(),
                  )),
              Expanded(
                child: MasonryGridView.builder(
                  controller: _controller,
                  padding: EdgeInsets.zero,
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: 30,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    _controller.addListener(() {
                      if (_controller.position.pixels != 0) {
                        hasAccess = false;
                        setState(() {});
                      } else {
                        hasAccess = true;
                        setState(() {});
                      }
                    });

                    return GridViewItem(
                      product: products[index],
                      cartItem: cartItems,
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
