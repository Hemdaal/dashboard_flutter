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

  static const String _getWidgetIdsQuery = r'''
  query getWidgets($projectId: Long!) {
  user {
    projectDashboard(projectId: $projectId) {
      widgets {
        id
      }
    }
  }
}
  ''';

  static const String _getWidgetQuery = r'''
  query getWidgets($projectId: Long!, $widgetId: Long!) {
  user {
    projectDashboard(projectId: $projectId) {
      widget(id: $widgetId) {
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

  Future<List<int>> getWidgetIds(int projectId) async {
    final QueryOptions options = QueryOptions(
      document: gql(_getWidgetIdsQuery),
      variables: {'projectId': projectId},
    );

    final QueryResult result = await query(options);

    if (result.hasException) {
      return Future.error(result.exception!);
    } else {
      List<dynamic> widgetIdsJson = result.data!['user']['projectDashboard']['widgets'];
      List<int> widgetIds = List.empty(growable: true);
      widgetIdsJson.forEach((element) {
        widgetIds.add(element['id']);
      });
      return Future.value(widgetIds);
    }
  }

  Future<DashboardWidget> getWidget(int projectId, int widgetId) async {
    final QueryOptions options = QueryOptions(
      document: gql(_getWidgetQuery),
      variables: {'projectId': projectId, 'widgetId': widgetId},
    );

    final QueryResult result = await query(options);

    if (result.hasException) {
      return Future.error(result.exception!);
    } else {
      Map<String, dynamic> widgetJson = result.data!['user']['projectDashboard']['widget'];
      return Future.value(DashboardWidget.fromJson(widgetJson));
    }
  }
}
