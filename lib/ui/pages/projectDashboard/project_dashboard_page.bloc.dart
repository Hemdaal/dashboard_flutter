import 'dart:async';

import 'package:hemdaal_ui_flutter/models/project.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class ProjectDashboardPageBloc extends Bloc {
  final _projectController = StreamController<Fetch<Project>>();
  final int _projectId;

  ProjectDashboardPageBloc(this._projectId);

  getProjectStream() => _projectController.stream;

  void getProjects() {
    _projectController.add(Fetch.setFetching());
    // _user.getProjects().then(
    //     (value) => _projectListController.sink.add(Fetch.setContent(value)),
    //     onError: (error) => _projectListController.sink.add(Fetch.setError(error)));
  }

  @override
  void dispose() {
    _projectController.close();
  }
}
