import 'package:pilatus/domain/entities/inventory.dart';

class InventoryModel {
  final int id;
  final int quantity;

  InventoryModel({required this.id, required this.quantity});

  factory InventoryModel.fromJson(Map<String, dynamic> json) => InventoryModel(
        id: json['id'],
        quantity: json['quantity'],
      );

  Inventory toEntity() {
    return Inventory(id: id, quantity: quantity);
  }
}
