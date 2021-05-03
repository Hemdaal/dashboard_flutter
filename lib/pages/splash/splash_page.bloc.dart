import 'dart:async';

import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class SplashPageBloc extends Bloc {
  final System _system;

  final _userStreamController = StreamController<Fetch<User>>();

  SplashPageBloc([System? system]) : this._system = system ?? System();

  Stream<Fetch<User>> getUserStream() => _userStreamController.stream;

  getUser() async {
    _userStreamController.sink.add(Fetch.setFetching());
    _system
        .getUser()
        .then((user) => _userStreamController.sink.add(Fetch.setContent(user)))
        .onError((error, stackTrace) => Fetch.setError(error));
  }

  @override
  void dispose() {
    _userStreamController.close();
  }
}
