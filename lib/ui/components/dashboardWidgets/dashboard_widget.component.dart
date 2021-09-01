import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget_type.dart';
import 'package:hemdaal_ui_flutter/ui/components/dashboardWidgets/commitByDay/commit_by_day.component.dart';

class DashboardWidgetComponent extends StatelessWidget {
  final DashboardWidget _dashboardWidget;

  DashboardWidgetComponent(this._dashboardWidget);

  @override
  Widget build(BuildContext context) {
    if (_dashboardWidget.type == DashboardWidgetType.COMMIT_BY_DAY) {
      return CommitByDayComponent(_dashboardWidget);
    } else {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Center(child: Text('Widget not supported')),
      );
    }
  }
}
