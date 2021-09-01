import 'package:hemdaal_ui_flutter/adapters/project_dashboard_adapter.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget_type.dart';

class ProjectDashboard {
  final int _projectId;
  final ProjectDashboardAdapter _dashboardAdapter;

  ProjectDashboard(this._projectId, {ProjectDashboardAdapter? dashboardAdapter})
      : this._dashboardAdapter = dashboardAdapter ?? ProjectDashboardAdapter();

  Future<List<DashboardWidget>> getDashboardWidgets() {
    return Future.value(List.empty());
  }

  Future<void> addWidget(DashboardWidgetType widgetType) {
    return this._dashboardAdapter.addWidget(_projectId, widgetType);
  }

  Future<List<DashboardWidget>> getWidgets() {
    return this._dashboardAdapter.getWidgets(_projectId);
  }

  Future<DashboardWidget> getWidget(int id) {
    return this._dashboardAdapter.getWidget(_projectId, id);
  }
}
