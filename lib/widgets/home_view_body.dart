import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food/models/product_model.dart';
import 'package:food/services/get_product_service.dart';
import 'package:food/widgets/widgets_above_slider.dart';

import 'auto_slidable_cards.dart';
import 'grid_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: AllProductService().getAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> products = snapshot.data!;
          return Column(
            children: [
              WidgetsAboveSlider(),
              SizedBox(
                height: 12,
              ),
              AutoSlidableCards(),
              Expanded(
                child: MasonryGridView.builder(
                  padding: EdgeInsets.zero,
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: 30,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) =>
                      GridViewItem(product: products[index]),
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
