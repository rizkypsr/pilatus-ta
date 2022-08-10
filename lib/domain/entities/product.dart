import 'package:pilatus/domain/entities/category.dart';
import 'package:pilatus/domain/entities/inventory.dart';

class Product {
  final int? id;
  final String? name;
  final String? photo;
  final String? blurhash;
  final String? description;
  final Category? category;
  final Inventory? inventory;
  final int? price;
  final double? weight;
  final String? updatedAt;

  Product(
      {this.id,
      this.name,
      this.photo,
      this.blurhash,
      this.description,
      this.category,
      this.inventory,
      this.price,
      this.weight,
      this.updatedAt});
}
