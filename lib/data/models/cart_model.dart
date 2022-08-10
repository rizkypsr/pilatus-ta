import 'package:pilatus/domain/entities/cart.dart';

class CartModel {
  final int id;
  final int userId;
  final int total;

  CartModel({required this.id, required this.userId, required this.total});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['id'],
        userId: json['user_id'],
        total: json['total'],
      );

  Cart toEntity() {
    return Cart(id: id, userId: userId, total: total);
  }
}
