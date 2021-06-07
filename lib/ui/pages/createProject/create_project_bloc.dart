import 'dart:async';

import 'package:hemdaal_ui_flutter/models/project.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class CreateProjectBloc extends Bloc {
  final _projectStreamController = StreamController<Fetch<Project>>();
  final User _user;

  

  CreateProjectBloc(this._user);
  Stream<Fetch<Project>> getProjectStream() => _projectStreamController.stream;

  @override
  void dispose() {
    _projectStreamController.close();
  }
}
