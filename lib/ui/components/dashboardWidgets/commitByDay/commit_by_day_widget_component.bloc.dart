import 'dart:async';

import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget.dart';
import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class CommitByDayWidgetComponentBloc extends Bloc {
  final _dashboardWidgetController = StreamController<Fetch<DashboardWidget>>();
  final System _system;

  CommitByDayWidgetComponentBloc({System? system}) : this._system = system ?? System();

  getDashboardWidgetStream() => _dashboardWidgetController.stream;

  void getDashboardWidget(int id, int projectId) {
    _dashboardWidgetController.sink.add(Fetch.setFetching());
    this
        ._system
        .getUser()
        .then((user) => user.getProject(projectId))
        .then((project) => project.getDashboard())
        .then((dashboard) => dashboard.getWidget(id))
        .then((value) => {_dashboardWidgetController.sink.add(Fetch.setContent(value))},
            onError: (error) => {_dashboardWidgetController.sink.add(Fetch.setError(error))});
  }

  @override
  void dispose() {
    _dashboardWidgetController.close();
  }
}
