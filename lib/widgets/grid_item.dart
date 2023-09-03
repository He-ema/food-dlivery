import 'package:flutter/material.dart';
import 'package:food/models/product_model.dart';
import 'package:food/widgets/product_bottom_sheet_body.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showBottomSheet(
            backgroundColor: Colors.white,
            enableDrag: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            context: context,
            builder: (context) => BroductBottomSheetBody(
                images: product.images,
                description: product.description,
                brand: product.brand),
          );
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[200], boxShadow: [
            BoxShadow(
                blurRadius: 1,
                color: Colors.grey,
                spreadRadius: 2,
                offset: Offset(1, 1))
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Image.network(product.image),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '\$' '${product.price + 50}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          '\$' '${product.price}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Positioned(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
