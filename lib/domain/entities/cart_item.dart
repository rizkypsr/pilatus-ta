import 'package:pilatus/domain/entities/cart.dart';
import 'package:pilatus/domain/entities/product.dart';

class CartItem {
  final int? id;
  final Product? product;
  final int? quantity;
  final Cart? cart;

  CartItem({this.id, this.product, this.quantity, this.cart});
}
