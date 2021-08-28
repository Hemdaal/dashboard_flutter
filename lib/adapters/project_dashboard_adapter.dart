import 'package:graphql/client.dart';
import 'package:hemdaal_ui_flutter/adapters/base_adapter.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget_type.dart';

class ProjectDashboardAdapter extends BaseNetworkAdapter {
  static const String _addWidgetQuery = r'''
  mutation addWidget($projectId: Long!, $type:String!, additionalInfo: String) {
  user {
    projectDashboard(projectId: $projectId) {
      addWidget(type: $type, additionalInfo: $additionalInfo) {
        id
      }
    }
  }
}
  ''';

  Future<void> addWidget(int projectId, DashboardWidgetType widgetType) async {
    final QueryOptions options = QueryOptions(
      document: gql(_addWidgetQuery),
      variables: {'projectId': projectId, 'type': widgetType.name},
    );

    final QueryResult result = await query(options);

    if (result.hasException) {
      return Future.error(result.exception!);
    } else {
      return Future.value(true);
    }
  }
}
