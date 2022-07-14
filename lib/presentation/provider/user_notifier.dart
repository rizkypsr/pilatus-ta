import 'package:flutter/material.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/user.dart';
import 'package:pilatus/domain/usecases/get_user.dart';

class AuthNotifier extends ChangeNotifier {
  final GetUser getUser;

  RequestState _userState = RequestState.Empty;
  RequestState get userState => _userState;

  var _user = User();
  User get user => _user;

  String _message = '';
  String get message => _message;

  AuthNotifier({required this.getUser});

  Future<void> fetchUser() async {
    _userState = RequestState.Loading;
    notifyListeners();

    var result = await getUser.execute();

    result.fold(
      (failure) {
        _userState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) async {
        _userState = RequestState.Loaded;
        _user = data;
        notifyListeners();
      },
    );
  }
}
