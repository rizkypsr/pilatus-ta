import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:pilatus/data/models/user_model.dart';
import 'package:pilatus/data/models/user_response.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser();
  Future<UserModel> changeUser(String name);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage storage;

  UserRemoteDataSourceImpl({required this.client, required this.storage});

  @override
  Future<UserModel> getUser() async {
    final String? token = await storage.read(key: 'token');

    final response = await client.get(Uri.parse('$baseUrlApi/user'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body)).user;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> changeUser(String name) async {
    final String? token = await storage.read(key: 'token');

    final response = await client.post(Uri.parse('$baseUrlApi/user'), headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Authorization': 'Bearer $token',
    }, body: {
      "name": name
    });

    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body)).user;
    } else {
      throw ServerException();
    }
  }
}
