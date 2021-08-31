import 'dart:async';

import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget_type.dart';
import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class ProjectDashboardPageBloc extends Bloc {
  final _dashboardWidgetIdsController = StreamController<Fetch<List<int>>>();
  final int _projectId;
  final System _system;

  ProjectDashboardPageBloc(this._projectId, {System? system}) : _system = system ?? System();

  getDashboardWidgetIdsStream() => _dashboardWidgetIdsController.stream;

  void getDashboardWidgets() {
    _dashboardWidgetIdsController.add(Fetch.setFetching());
    _system
        .getUser()
        .then((user) => user.getDashboard(_projectId))
        .then((dashboard) => dashboard.getWidgetIds())
        .then((widgets) => _dashboardWidgetIdsController.sink.add(Fetch.setContent(widgets)), onError: (error) => _dashboardWidgetIdsController.sink.add(Fetch.setError(error)));
  }

  @override
  void dispose() {
    _dashboardWidgetIdsController.close();
  }

  void addWidget(DashboardWidgetType widgetType) {
    _dashboardWidgetIdsController.add(Fetch.setFetching());
    _system
        .getUser()
        .then((user) => user.getDashboard(_projectId))
        .then((dashboard) => dashboard.addWidget(widgetType))
        .then((value) => getDashboardWidgets());
  }
}
