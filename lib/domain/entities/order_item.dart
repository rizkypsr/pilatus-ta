import 'package:pilatus/domain/entities/product.dart';

class OrderItem {
  int? id;
  int? quantity;
  String? updatedAt;
  Product? product;

  OrderItem({this.id, this.quantity, this.updatedAt, this.product});
}
