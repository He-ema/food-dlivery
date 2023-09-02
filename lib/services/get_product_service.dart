import 'package:food/helpers/api.dart';
import 'package:food/models/product_model.dart';

class AllProductService {
  Future<List<ProductModel>> getAllProducts() async {
    Map<String, dynamic> data = await Api().get(
      Url: 'https://dummyjson.com/products',
    );
    List<dynamic> Productdata = data['products'];
    List<ProductModel> realData = [];
    for (int i = 0; i < Productdata.length; i++) {
      realData.add(ProductModel.fromJson(Productdata[i]));
    }
    return realData;
  }
}
