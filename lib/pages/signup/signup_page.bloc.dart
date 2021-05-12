import 'dart:async';

import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class SignupPageBloc extends Bloc {
  final _userController = StreamController<Fetch<User>>();
  final System _system;

  SignupPageBloc({System? system}) : _system = system ?? System();

  Stream<Fetch<User>> getUserStream() => _userController.stream;

  signup(String name, String email, String password) async {
    _userController.sink.add(Fetch.setFetching());
    _system.register(name, email, password).then(
        (value) => _userController.sink.add(Fetch.setContent(value)),
        onError: (error) => _userController.sink.add(Fetch.setError(error)));
  }

  @override
  void dispose() {
    _userController.close();
  }
}
