import 'package:pilatus/data/models/category_model.dart';

class CategoryResponse {
  final List<CategoryModel> categories;

  CategoryResponse({required this.categories});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        categories: List<CategoryModel>.from(
            (json["data"] as List).map((x) => CategoryModel.fromJson(x))),
      );
}
