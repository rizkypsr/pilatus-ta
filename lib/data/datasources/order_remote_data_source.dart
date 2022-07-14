import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/models/order_list_response.dart';
import 'package:pilatus/data/models/order_model.dart';
import 'package:pilatus/data/models/order_response.dart';
import 'package:http/http.dart' as http;
import 'package:pilatus/domain/entities/shipping.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> checkout(Shipping shipping, int cartId);
  Future<OrderModel> getOrder(String id);
  Future<List<OrderModel>> getOrderByStatus(String status);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage storage;

  OrderRemoteDataSourceImpl({required this.client, required this.storage});

  @override
  Future<OrderModel> checkout(Shipping shipping, int cartId) async {
    final String? token = await storage.read(key: 'token');

    final body = json.encode({
      "address": shipping.address,
      "province": shipping.province,
      "city": shipping.city,
      "postal_code": shipping.postalCode,
      "courier": shipping.courier,
      "service": shipping.service,
      "cost": shipping.cost
    });

    final response =
        await client.post(Uri.parse('$baseUrlApi/order/checkout/$cartId'),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $token',
            },
            body: body);

    if (response.statusCode == 200) {
      return OrderResponse.fromJson(jsonDecode(response.body)).orders;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<OrderModel>> getOrderByStatus(String status) async {
    final String? token = await storage.read(key: 'token');

    final response =
        await client.get(Uri.parse('$baseUrlApi/orders/$status'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return OrderListResponse.fromJson(jsonDecode(response.body)).orders;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<OrderModel> getOrder(String id) async {
    final String? token = await storage.read(key: 'token');

    final response =
        await client.get(Uri.parse('$baseUrlApi/order/$id'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return OrderResponse.fromJson(jsonDecode(response.body)).orders;
    } else {
      throw ServerException();
    }
  }
}
