class ProductModel {
  final String name;
  final int price;
  final String image;
  final List<dynamic> images;
  final String description;
  final String brand;
  final int id;

  ProductModel(
      {required this.name,
      required this.price,
      required this.description,
      required this.brand,
      required this.image,
      required this.id,
      required this.images});

  factory ProductModel.fromJson(jsonData) {
    return ProductModel(
      name: jsonData['title'],
      price: jsonData['price'],
      image: jsonData['thumbnail'],
      images: jsonData['images'],
      description: jsonData['description'],
      brand: jsonData['brand'],
      id: jsonData['id'],
    );
  }
}
