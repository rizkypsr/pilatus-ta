import 'package:pilatus/data/models/cart_model.dart';
import 'package:pilatus/data/models/product_model.dart';
import 'package:pilatus/domain/entities/cart_item.dart';

class CartItemModel {
  final int id;
  final ProductModel product;
  final int quantity;
  final CartModel cart;

  CartItemModel(
      {required this.id,
      required this.product,
      required this.quantity,
      required this.cart});

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        id: json['id'],
        product: ProductModel.fromJson(json['product']),
        quantity: json['quantity'],
        cart: CartModel.fromJson(json['cart']),
      );

  CartItem toEntity() {
    return CartItem(
      id: id,
      product: product.toEntity(),
      quantity: quantity,
      cart: cart.toEntity(),
    );
  }
}
