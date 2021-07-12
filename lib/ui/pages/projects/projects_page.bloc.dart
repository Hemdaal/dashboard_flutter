import 'dart:async';

import 'package:hemdaal_ui_flutter/models/project.dart';
import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class ProjectsPageBloc extends Bloc {
  final _projectListController = StreamController<Fetch<List<Project>>>();
  final System _system;

  ProjectsPageBloc({System? system}) : this._system = system ?? System();

  getUserStream() => _projectListController.stream;

  void getProjects() {
    _projectListController.add(Fetch.setFetching());
    _system.getUser().then((user) => user.getProjects().then(
            (value) => _projectListController.sink.add(Fetch.setContent(value)),
        onError: (error) =>
            _projectListController.sink.add(Fetch.setError(error))).onError((error, stackTrace) => null));
  }

  @override
  void dispose() {
    _projectListController.close();
  }
}
