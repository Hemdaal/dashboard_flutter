import 'package:graphql/client.dart';
import 'package:hemdaal_ui_flutter/adapters/base_adapter.dart';
import 'package:hemdaal_ui_flutter/models/project.dart';

class ProjectAdapter extends BaseNetworkAdapter {
  static const String _projectsQuery = r'''
  query GetProjects() {
    user {
      projects {
        id
        name
      }
    }
  }
  ''';

  Future<List<Project>> getProjects() async {
    final QueryOptions options = QueryOptions(document: gql(_projectsQuery));

    final QueryResult result = await query(options);

    if (result.hasException) {
      return Future.error(result.exception!);
    } else {
      List<dynamic?> projectsJson = result.data!['user']['projects'];
      List<Project> projects = List.empty(growable: true);
      projectsJson.forEach((element) {
        projects.add(Project.fromJson(element));
      });
      return Future.value(projects);
    }
  }
}
