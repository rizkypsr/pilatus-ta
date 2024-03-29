import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/models/cart_item_model.dart';
import 'package:http/http.dart' as http;
import 'package:pilatus/data/models/cart_item_response.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<String> addToCart(int productId);
  Future<String> removeCartItem(int cartItemId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage storage;

  CartRemoteDataSourceImpl({required this.client, required this.storage});

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final String? token = await storage.read(key: 'token');

    final response = await client.get(Uri.parse('$baseUrlApi/cart'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return CartItemResponse.fromJson(jsonDecode(response.body)).cartItems;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> addToCart(int productId) async {
    final String? token = await storage.read(key: 'token');

    final body = json.encode({'product_id': productId});

    final response = await client.post(Uri.parse('$baseUrlApi/cart'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: body);

    if (response.statusCode == 200) {
      return 'Berhasil menambahkan produk ke keranjang';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> removeCartItem(int cartItemId) async {
    final String? token = await storage.read(key: 'token');

    final response = await client.delete(
      Uri.parse('$baseUrlApi/cart/$cartItemId'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return 'Berhasil menghapus produk dari keranjang';
    } else {
      throw ServerException();
    }
  }
}
