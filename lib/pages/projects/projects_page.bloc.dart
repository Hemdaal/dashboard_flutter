import 'dart:async';

import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class ProjectsPageBloc extends Bloc {
  final _userController = StreamController<Fetch<User>>();
  final System _system;

  ProjectsPageBloc({System? system}) : _system = system ?? System();

  Stream<Fetch<User>> getUserStream() => _userController.stream;

  login(String email, String password) async {
    await _system.login(email, password);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
