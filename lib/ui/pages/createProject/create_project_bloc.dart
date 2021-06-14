import 'dart:async';

import 'package:hemdaal_ui_flutter/models/project.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/create_project_info.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/console_log.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class CreateProjectBloc extends Bloc {
  final _projectStreamController = StreamController<Fetch<Project>>();
  final _createProjectStreamController = StreamController<CreateProjectInfo>();
  final User _user;
  CreateProjectInfo _createProjectInfo = CreateProjectInfo();

  CreateProjectBloc(this._user);

  Stream<Fetch<Project>> getProjectStream() => _projectStreamController.stream;

  Stream<CreateProjectInfo> getCreateProjectInfoStream() {
    _createProjectStreamController.sink.add(_createProjectInfo);
    return _createProjectStreamController.stream;
  }

  void update(CreateProjectInfo createProjectInfo) {
    _createProjectInfo = createProjectInfo;
    _createProjectStreamController.sink.add(_createProjectInfo);
  }

  @override
  void dispose() {
    _projectStreamController.close();
    _createProjectStreamController.close();
  }

  createProject(CreateProjectInfo data) {
    _createProjectInfo.setCreating();
    _createProjectStreamController.sink.add(_createProjectInfo);
    this._user.createProject(data).then((value) =>
    {
      _createProjectInfo.setProjectCreated(value.id),
      _createProjectStreamController.sink.add(_createProjectInfo)
    }).onError((error, stackTrace) =>
    {
      ConsoleLog.i('error'),
      _createProjectInfo.setError(error),
      _createProjectStreamController.sink.add(_createProjectInfo)
    });
  }
}
