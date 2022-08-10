import 'package:pilatus/data/models/order_item_model.dart';
import 'package:pilatus/data/models/payment_model.dart';
import 'package:pilatus/data/models/shipping_model.dart';
import 'package:pilatus/data/models/user_model.dart';
import 'package:pilatus/domain/entities/order.dart';

class OrderModel {
  final String id;
  final UserModel? user;
  final int total;
  final PaymentModel? payment;
  final String status;
  final String updatedAt;
  final String paymentUrl;
  final ShippingModel? shipping;
  final List<OrderItemModel>? orderItems;

  OrderModel(
      {required this.id,
      this.user,
      required this.total,
      this.payment,
      required this.status,
      required this.updatedAt,
      required this.paymentUrl,
      this.shipping,
      required this.orderItems});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      status: json['status'],
      total: json['total'],
      paymentUrl: json['payment_url'],
      updatedAt: json['updated_at'],
      payment: json['payment'] != null
          ? PaymentModel.fromJson(json['payment'])
          : null,
      orderItems: json['order_item'] != null
          ? List<OrderItemModel>.from((json["order_item"] as List)
              .map((x) => OrderItemModel.fromJson(x)))
          : null,
      shipping: json['shipping'] != null
          ? ShippingModel.fromJson(json['shipping'])
          : null);

  Orders toEntity() {
    return Orders(
        id: id,
        status: status,
        total: total,
        paymentUrl: paymentUrl,
        updatedAt: updatedAt,
        user: user != null ? user!.toEntity() : null,
        orderItem: orderItems != null
            ? orderItems!.map((item) => item.toEntity()).toList()
            : null,
        payment: payment != null ? payment!.toEntity() : null,
        shipping: shipping != null ? shipping!.toEntity() : null);
  }
}
