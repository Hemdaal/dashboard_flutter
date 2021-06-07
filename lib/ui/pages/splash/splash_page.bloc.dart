import 'dart:async';

import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class SplashPageBloc extends Bloc {
  final System _system;

  final _userStreamController = StreamController<Fetch<User>>();

  SplashPageBloc([System? system]) : this._system = system ?? System();

  @override
  void init() {
    super.init();
    _getUser();
  }

  getUserStream() => _userStreamController.stream;

  void _getUser() {
    _userStreamController.add(Fetch.setFetching());
    _system.getUser().then(
        (value) => _userStreamController.sink.add(Fetch.setContent(value)),
        onError: (error) => _userStreamController.sink.add(Fetch.setError(error)));
  }

  @override
  void dispose() {
    _userStreamController.close();
  }
}
