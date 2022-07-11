import 'package:pilatus/data/models/cart_item_model.dart';
import 'package:pilatus/data/models/order_model.dart';

class OrderResponse {
  final OrderModel orders;

  OrderResponse({required this.orders});

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        orders: OrderModel.fromJson(json['data']),
      );
}
