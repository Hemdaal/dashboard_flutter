import 'dart:async';

import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget.dart';
import 'package:hemdaal_ui_flutter/models/system.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class DashboardWidgetComponentBloc extends Bloc {
  final _dashboardWidgetController = StreamController<Fetch<DashboardWidget>>();
  final System _system;

  DashboardWidgetComponentBloc({System? system}) : this._system = system ?? System();

  getDashboardWidgetStream() => _dashboardWidgetController.stream;

  void getDashboardWidget(int id) {

  }

  @override
  void dispose() {
    _dashboardWidgetController.close();
  }
}
