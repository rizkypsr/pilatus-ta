import 'dart:convert';

import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/models/category_model.dart';
import 'package:pilatus/data/models/category_response.dart';
import 'package:pilatus/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:pilatus/data/models/product_response.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response =
        await client.get(Uri.parse('$baseUrlApi/categories'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return CategoryResponse.fromJson(jsonDecode(response.body)).categories;
    } else {
      throw ServerException();
    }
  }
}
