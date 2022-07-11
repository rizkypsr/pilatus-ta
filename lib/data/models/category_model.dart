import 'package:pilatus/domain/entities/category.dart';

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['name'],
      );

  Category toEntity() {
    return Category(id: id, name: name);
  }
}
