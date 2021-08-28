import 'dart:async';

import 'package:hemdaal_ui_flutter/models/dashboard/project_dashboard.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget_type.dart';
import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class ProjectDashboardPageBloc extends Bloc {
  final _projectDashboardController = StreamController<Fetch<ProjectDashboard>>();
  final int _projectId;
  final System _system;

  ProjectDashboardPageBloc(this._projectId, {System? system}) : _system = system ?? System();

  getProjectStream() => _projectDashboardController.stream;

  void getDashboard() {
    _projectDashboardController.add(Fetch.setFetching());
    _system.getUser().then((user) => user.getDashboard(_projectId)).then(
        (dashboard) => _projectDashboardController.sink.add(Fetch.setContent(dashboard)),
        onError: (error) => _projectDashboardController.sink.add(Fetch.setError(error)));
  }

  @override
  void dispose() {
    _projectDashboardController.close();
  }

  void addWidget(DashboardWidgetType widgetType) {
    _projectDashboardController.add(Fetch.setFetching());
    _system
        .getUser()
        .then((user) => user.getDashboard(_projectId))
        .then((dashboard) => dashboard.addWidget(widgetType))
        .then((value) => getDashboard());
  }
}
