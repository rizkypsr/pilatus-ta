import 'package:pilatus/domain/entities/order_item.dart';
import 'package:pilatus/domain/entities/payment.dart';
import 'package:pilatus/domain/entities/shipping.dart';
import 'package:pilatus/domain/entities/user.dart';

class Orders {
  String? id;
  User? user;
  int? total;
  Payment? payment;
  String? status;
  String? updatedAt;
  String? paymentUrl;
  Shipping? shipping;
  List<OrderItem>? orderItem;

  Orders(
      {this.id,
      this.user,
      this.total,
      this.payment,
      this.status,
      this.updatedAt,
      this.paymentUrl,
      this.shipping,
      this.orderItem});
}
