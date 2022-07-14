import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/models/category_model.dart';
import 'package:pilatus/data/models/category_response.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage storage;

  CategoryRemoteDataSourceImpl({required this.client, required this.storage});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final String? token = await storage.read(key: 'token');

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
