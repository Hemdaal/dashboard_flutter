import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget.dart';
import 'package:hemdaal_ui_flutter/ui/components/dashboardWidgets/dashboard_widget_component.bloc.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class DashboardWidgetComponent extends StatelessWidget {
  final int _id;
  final DashboardWidgetComponentBloc _bloc;

  DashboardWidgetComponent(this._id, {DashboardWidgetComponentBloc? bloc})
      : this._bloc = bloc ?? DashboardWidgetComponentBloc();

  @override
  Widget build(BuildContext context) {
    _bloc.getDashboardWidget(_id);
    return BlocProvider(bloc: _bloc, child: _render(context));
  }

  Widget _render(BuildContext context) {
    return StreamBuilder<Fetch<DashboardWidget>>(
        stream: _bloc.getDashboardWidgetStream(),
        builder: (context, snapshot) {
          if (snapshot.data?.isSuccess() == true) {
          } else if (snapshot.data?.isError() == true) {
          } else {
            return CircularProgressIndicator();
          }
          return CircularProgressIndicator();
        });
  }
}
