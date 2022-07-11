import 'package:pilatus/data/models/product_model.dart';
import 'package:pilatus/domain/entities/order.dart';
import 'package:pilatus/domain/entities/order_item.dart';
import 'package:pilatus/domain/entities/product.dart';

class OrderItemModel {
  final int id;
  final int quantity;
  final String updatedAt;
  final ProductModel product;

  OrderItemModel(
      {required this.id,
      required this.quantity,
      required this.updatedAt,
      required this.product});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        id: json['id'],
        quantity: json['quantity'],
        updatedAt: json['updated_at'],
        product: ProductModel.fromJson(json['product']),
      );

  OrderItem toEntity() {
    return OrderItem(
        id: id,
        quantity: quantity,
        product: product.toEntity(),
        updatedAt: updatedAt);
  }
}
