import 'package:pilatus/data/models/auth_model.dart';
import 'package:pilatus/data/models/cart_item_model.dart';
import 'package:pilatus/data/models/user_model.dart';

class AuthResponse {
  final AuthModel authModel;

  AuthResponse({required this.authModel});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      AuthResponse(authModel: AuthModel.fromJson(json['data']));
}
