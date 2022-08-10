import 'package:pilatus/data/models/category_model.dart';
import 'package:pilatus/data/models/inventory_model.dart';
import 'package:pilatus/domain/entities/product.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final CategoryModel category;
  final InventoryModel inventory;
  final int price;
  final double weight;
  final String photo;
  final String blurhash;
  final String updatedAt;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.inventory,
      required this.price,
      required this.weight,
      required this.photo,
      required this.blurhash,
      required this.updatedAt});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['desc'],
      category: CategoryModel.fromJson(json['category']),
      inventory: InventoryModel.fromJson(json['inventory']),
      price: json['price'],
      weight: json['weight'].toDouble(),
      photo: json['photo'],
      blurhash: json['blurhash'],
      updatedAt: json['updated_at']);

  Product toEntity() {
    return Product(
        id: id,
        name: name,
        description: description,
        category: category.toEntity(),
        inventory: inventory.toEntity(),
        price: price,
        weight: weight,
        photo: photo,
        blurhash: blurhash,
        updatedAt: updatedAt);
  }
}
