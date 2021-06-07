import 'dart:async';

import 'package:hemdaal_ui_flutter/models/project.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class ProjectsPageBloc extends Bloc {
  final _projectListController = StreamController<Fetch<List<Project>>>();
  final User _user;

  ProjectsPageBloc(this._user);

  getUserStream() => _projectListController.stream;

  @override
  void init() {
    getProjects();
    super.init();
  }

  void getProjects() {
    _projectListController.add(Fetch.setFetching());
    _user.getProjects().then(
        (value) => _projectListController.sink.add(Fetch.setContent(value)),
        onError: (error) => _projectListController.sink.add(Fetch.setError(error)));
  }

  @override
  void dispose() {
    _projectListController.close();
  }
}
