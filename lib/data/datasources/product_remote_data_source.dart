import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:pilatus/data/models/product_response.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getProductByCategory(int categoryId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage storage;

  ProductRemoteDataSourceImpl({required this.client, required this.storage});

  @override
  Future<List<ProductModel>> getProducts() async {
    final String? token = await storage.read(key: 'token');

    final response =
        await client.get(Uri.parse('$baseUrlApi/products'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(jsonDecode(response.body)).productList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProductByCategory(int categoryId) async {
    final String? token = await storage.read(key: 'token');

    final response = await client
        .get(Uri.parse('$baseUrlApi/products/category/$categoryId'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(jsonDecode(response.body)).productList;
    } else {
      throw ServerException();
    }
  }
}
