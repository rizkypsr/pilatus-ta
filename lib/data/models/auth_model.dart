import 'package:pilatus/data/models/user_model.dart';
import 'package:pilatus/domain/entities/auth.dart';

class AuthModel {
  final String token;
  final UserModel user;

  AuthModel({required this.token, required this.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      AuthModel(token: json['token'], user: UserModel.fromJson(json['user']));

  Auth toEntity() {
    return Auth(token: token, user: user.toEntity());
  }
}
