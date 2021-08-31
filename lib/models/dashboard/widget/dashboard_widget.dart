import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget_type.dart';

class DashboardWidget {
  final int id;
  final DashboardWidgetType type;

  DashboardWidget(this.id, this.type);

  DashboardWidget.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = DashboardWidgetType.values.firstWhere((element) {
          return element.value == json['type'];
        });
}
