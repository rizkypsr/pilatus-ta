import 'package:pilatus/domain/entities/user.dart';

class Auth {
  final String? token;
  final User? user;

  Auth({this.token, this.user});
}
