import 'package:pilatus/data/models/order_model.dart';

class OrderListResponse {
  final List<OrderModel> orders;

  OrderListResponse({required this.orders});

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      OrderListResponse(
        orders: List<OrderModel>.from(
            (json["data"] as List).map((x) => OrderModel.fromJson(x))),
      );
}
