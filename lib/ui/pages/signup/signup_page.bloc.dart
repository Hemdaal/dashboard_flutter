import 'dart:async';

import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class SignupPageBloc extends Bloc {
  final _userController = StreamController<Fetch<User>>();
  final System _system;

  SignupPageBloc({System? system}) : _system = system ?? System();

  getUserStream() => _userController.stream;

  _getUserSink() => _userController.sink;

  void signup(String name, String email, String password) {
    _userController.add(Fetch.setFetching());
    _system.register(name, email, password).then(
        (value) => _getUserSink().add(Fetch.setContent(value)),
        onError: (error) => _getUserSink().addError(error));
  }

  @override
  void dispose() {
    _userController.close();
  }
}
