import 'package:pilatus/data/models/product_model.dart';

class ProductResponse {
  final List<ProductModel> productList;

  ProductResponse({required this.productList});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        productList: List<ProductModel>.from(
            (json["data"] as List).map((x) => ProductModel.fromJson(x))),
      );
}
