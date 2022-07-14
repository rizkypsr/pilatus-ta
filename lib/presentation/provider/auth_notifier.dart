import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/usecases/login.dart';
import 'package:pilatus/domain/usecases/logout.dart';
import 'package:pilatus/domain/usecases/register.dart';

class AuthNotifier extends ChangeNotifier {
  final FlutterSecureStorage storage;
  final Login login;
  final Register register;
  final Logout logout;

  AuthState _authState = AuthState.Unauthenticated;
  AuthState get authState => _authState;

  String _message = '';
  String get message => _message;

  AuthNotifier(
      {required this.storage,
      required this.login,
      required this.register,
      required this.logout});

  Future<void> logoutUser() async {
    _authState = AuthState.Loading;
    notifyListeners();

    var result = await logout.execute();

    result.fold(
      (failure) {
        _authState = AuthState.Erorr;
        _message = failure.message;
        notifyListeners();
      },
      (data) async {
        _authState = AuthState.Unauthenticated;
        await storage.delete(key: 'token');
        notifyListeners();
      },
    );
  }

  Future<void> loginUser(String email, String password) async {
    // _authState = AuthState.Loading;
    // notifyListeners();

    var result = await login.execute(email, password);

    result.fold(
      (failure) {
        _authState = AuthState.Erorr;
        _message = failure.message;
        notifyListeners();
      },
      (data) async {
        _authState = AuthState.Authenticated;
        await storage.write(key: 'token', value: data.token);
        notifyListeners();
      },
    );
  }

  Future<void> registerUser(String name, String email, String password) async {
    _authState = AuthState.Loading;
    notifyListeners();

    var result = await register.execute(name, email, password);

    result.fold(
      (failure) {
        _authState = AuthState.Erorr;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _authState = AuthState.Authenticated;
        storage.write(key: 'token', value: data.token);
        notifyListeners();
      },
    );
  }

  Future<void> checkAuth() async {
    _authState = AuthState.Loading;
    notifyListeners();

    String? token = await storage.read(key: 'token');

    if (token != null) {
      _authState = AuthState.Authenticated;
    } else {
      _authState = AuthState.Unauthenticated;
    }

    notifyListeners();
  }
}
