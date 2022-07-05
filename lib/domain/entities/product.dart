class Product {
  final int? id;
  final String? name;
  final String? photo;
  final String? description;
  final int? categoryId;
  final int? inventoryId;
  final int? price;
  final double? weight;
  final DateTime? updatedAt;

  Product(
      {this.id,
      this.name,
      this.photo,
      this.description,
      this.categoryId,
      this.inventoryId,
      this.price,
      this.weight,
      this.updatedAt});
}
