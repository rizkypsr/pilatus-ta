import 'package:pilatus/data/models/cart_item_model.dart';

class CartItemResponse {
  final List<CartItemModel> cartItems;

  CartItemResponse({required this.cartItems});

  factory CartItemResponse.fromJson(Map<String, dynamic> json) =>
      CartItemResponse(
        cartItems: List<CartItemModel>.from((json["data"]['cartItems'] as List)
            .map((x) => CartItemModel.fromJson(x))),
      );
}
