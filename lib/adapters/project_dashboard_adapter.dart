import 'package:graphql/client.dart';
import 'package:hemdaal_ui_flutter/adapters/base_adapter.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget_type.dart';

class ProjectDashboardAdapter extends BaseNetworkAdapter {
  static const String _addWidgetQuery = r'''
  mutation addWidget($projectId: Long!, $type:ProjectWidgetType!, $additionalInfo: String) {
  user {
    projectDashboard(projectId: $projectId) {
      addWidget(type: $type, additionalInfo: $additionalInfo) {
        id
      }
    }
  }
}
  ''';

  static const String _getWidgetsQuery = r'''
  query getWidgets($projectId: Long!) {
  user {
    projectDashboard(projectId: $projectId) {
      widgets() {
        id,
        type,
        additionalInfo
      }
    }
  }
}
  ''';

  Future<void> addWidget(int projectId, DashboardWidgetType widgetType) async {
    final QueryOptions options = QueryOptions(
      document: gql(_addWidgetQuery),
      variables: {'projectId': projectId, 'type': widgetType.value, 'additionalInfo': null},
    );

    final QueryResult result = await query(options);

    if (result.hasException) {
      return Future.error(result.exception!);
    } else {
      return Future.value(true);
    }
  }

  Future<List<DashboardWidget>> getWidgets(int projectId) async {
    final QueryOptions options = QueryOptions(
      document: gql(_getWidgetsQuery),
      variables: {'projectId': projectId},
    );

    final QueryResult result = await query(options);

    if (result.hasException) {
      return Future.error(result.exception!);
    } else {
      List<dynamic> widgetsJson = result.data!['user']['projectDashboard']['widgets'];
      List<DashboardWidget> widgets = List.empty(growable: true);
      widgetsJson.forEach((element) {
        widgets.add(DashboardWidget.fromJson(element));
      });
      return Future.value(widgets);
    }
  }
}
