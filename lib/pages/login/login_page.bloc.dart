import 'dart:async';

import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class LoginPageBloc extends Bloc {
  final _userController = StreamController<Fetch<User>>();
  final System _system;

  LoginPageBloc({System? system}) : _system = system ?? System();

  Stream<Fetch<User>> getUserStream() => _userController.stream;

  login(String email, String password) {
    _userController.sink.add(Fetch.setFetching());
    _system.login(email, password).then((value) => _userController.sink.add(Fetch.setContent(value)), onError: () => _userController.sink.add(Fetch.setError()));
  }

  @override
  void dispose() {
    _userController.close();
  }
}
