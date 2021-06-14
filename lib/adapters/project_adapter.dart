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

  static const String _createProjectsQuery = r'''
  mutation createProject($name:String!) {
  user {
    createProject(name:$name) {
      id,
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
      List<dynamic> projectsJson = result.data!['user']['projects'];
      List<Project> projects = List.empty(growable: true);
      projectsJson.forEach((element) {
        projects.add(Project.fromJson(element));
      });
      return Future.value(projects);
    }
  }

  Future<Project> createProject(String name) async {
    final QueryOptions options = QueryOptions(
      document: gql(_createProjectsQuery),
      variables: {'name': name},
    );

    final QueryResult result = await query(options);

    if (result.hasException) {
      return Future.error(result.exception!);
    } else {
      Map<String, dynamic> projectsJson = result.data!['user']['createProject'];
      return Future.value(Project.fromJson(projectsJson));
    }
  }
}
