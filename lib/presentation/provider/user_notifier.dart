import 'package:flutter/material.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/user.dart';
import 'package:pilatus/domain/usecases/change_user.dart';
import 'package:pilatus/domain/usecases/get_user.dart';

class UserNotifier extends ChangeNotifier {
  final GetUser getUser;
  final ChangeUser changeUser;

  RequestState _userState = RequestState.Empty;
  RequestState get userState => _userState;

  RequestState _changeUserState = RequestState.Empty;
  RequestState get changeUserState => _changeUserState;

  var _user = User();
  User get user => _user;

  String _message = '';
  String get message => _message;

  UserNotifier({required this.getUser, required this.changeUser});

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

  Future<void> changeUserName(String name) async {
    _changeUserState = RequestState.Loading;
    notifyListeners();

    var result = await changeUser.execute(name);

    result.fold(
      (failure) {
        _changeUserState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) async {
        _changeUserState = RequestState.Loaded;
        _user = data;
        notifyListeners();
      },
    );
  }
}
