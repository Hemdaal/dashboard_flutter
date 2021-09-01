import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

import 'commit_by_day_widget_component.bloc.dart';

class CommitByDayComponent extends StatelessWidget {
  final DashboardWidget _dashboardWidget;
  final CommitByDayWidgetComponentBloc _bloc;

  CommitByDayComponent(this._dashboardWidget, {CommitByDayWidgetComponentBloc? bloc})
      : this._bloc = bloc ?? CommitByDayWidgetComponentBloc();

  @override
  Widget build(BuildContext context) {
    //_bloc.getDashboardWidget(_id, _projectId);
    return BlocProvider(bloc: _bloc, child: _render(context));
  }

  Widget _render(BuildContext context) {
    return StreamBuilder<Fetch<DashboardWidget>>(
        stream: _bloc.getDashboardWidgetStream(),
        builder: (context, snapshot) {
          if (snapshot.data?.isSuccess() == true) {
          } else if (snapshot.data?.isError() == true) {
            return Text('unable to fetch info');
          } else {
            return CircularProgressIndicator();
          }
          return CircularProgressIndicator();
        });
  }
}
