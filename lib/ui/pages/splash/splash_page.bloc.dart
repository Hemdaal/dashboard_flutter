import 'dart:async';

import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class SplashPageBloc extends Bloc {
  final System _system;

  final _userStreamController = StreamController<Fetch<User>>();

  SplashPageBloc([System? system]) : this._system = system ?? System();

  get userStream {
    return _userStreamController.stream;
  }

  void getUser() {
    _userStreamController.sink.add(Fetch.setFetching());
    _system.getUser().then(
        (value) => _userStreamController.sink.add(Fetch.setContent(value)),
        onError: (error) {
      _userStreamController.sink.add(Fetch.setError(error));
    });
  }

  @override
  void dispose() {
    _userStreamController.close();
  }
}
