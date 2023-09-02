class ProductModel {
  final String name;
  final int price;
  final String image;
  final List<dynamic> images;

  ProductModel(
      {required this.name,
      required this.price,
      required this.image,
      required this.images});

  factory ProductModel.fromJson(jsonData) {
    return ProductModel(
      name: jsonData['title'],
      price: jsonData['price'],
      image: jsonData['thumbnail'],
      images: jsonData['images'],
    );
  }
}
