import 'dart:async';

import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget_type.dart';
import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class ProjectDashboardPageBloc extends Bloc {
  final _dashboardWidgetsController = StreamController<Fetch<List<DashboardWidget>>>();
  final int _projectId;
  final System _system;

  ProjectDashboardPageBloc(this._projectId, {System? system}) : _system = system ?? System();

  getDashboardWidgetsStream() => _dashboardWidgetsController.stream;

  void getDashboardWidgets() {
    _dashboardWidgetsController.add(Fetch.setFetching());
    _system
        .getUser()
        .then((user) => user.getDashboard(_projectId))
        .then((dashboard) => dashboard.getWidgets())
        .then((widgets) => _dashboardWidgetsController.sink.add(Fetch.setContent(widgets)), onError: (error) => _dashboardWidgetsController.sink.add(Fetch.setError(error)));
  }

  @override
  void dispose() {
    _dashboardWidgetsController.close();
  }

  void addWidget(DashboardWidgetType widgetType) {
    _dashboardWidgetsController.add(Fetch.setFetching());
    _system
        .getUser()
        .then((user) => user.getDashboard(_projectId))
        .then((dashboard) => dashboard.addWidget(widgetType))
        .then((value) => getDashboardWidgets());
  }
}
