import 'package:pilatus/data/models/category_model.dart';
import 'package:pilatus/data/models/user_model.dart';

class UserResponse {
  final UserModel user;

  UserResponse({required this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        user: UserModel.fromJson(json['data']),
      );
}
