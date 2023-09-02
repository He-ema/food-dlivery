import 'package:flutter/material.dart';
import 'package:food/models/product_model.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          child: Column(
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
        ),
      ),
    );
  }
}
