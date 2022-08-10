import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/exception.dart';
import 'package:pilatus/data/models/auth_model.dart';
import 'package:pilatus/data/models/auth_response.dart';
import 'package:http/http.dart' as http;
import 'package:pilatus/data/models/logout_response.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<AuthModel> register(String name, String email, String password);
  Future<bool> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage storage;

  AuthRemoteDataSourceImpl({required this.client, required this.storage});

  @override
  Future<AuthModel> login(String email, String password) async {
    final body = json.encode({
      "email": email,
      "password": password,
    });

    final response = await client.post(Uri.parse('$baseUrlApi/login'),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body)).authModel;
    } else if (response.statusCode == 500) {
      throw AuthenticationException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> register(String name, String email, String password) async {
    final body = json.encode({
      "name": name,
      "email": email,
      "password": password,
    });

    final response = await client.post(Uri.parse('$baseUrlApi/register'),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body)).authModel;
    } else if (response.statusCode == 403) {
      throw AuthenticationException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> logout() async {
    final String? token = await storage.read(key: 'token');

    final response =
        await client.post(Uri.parse('$baseUrlApi/logout'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return LogoutResponse.fromJson(jsonDecode(response.body)).logged;
    } else {
      throw ServerException();
    }
  }
}
