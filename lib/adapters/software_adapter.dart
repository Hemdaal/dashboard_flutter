import 'package:graphql/client.dart';
import 'package:hemdaal_ui_flutter/adapters/base_adapter.dart';
import 'package:hemdaal_ui_flutter/models/CodeManagement.dart';
import 'package:hemdaal_ui_flutter/models/SoftwareComponent.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/git_tool_type.dart';

class SoftwareAdapter extends BaseNetworkAdapter {
  static const String _createSoftwareQuery = r'''
  mutation createProject($projectId: Long!, $name:String!) {
  user {
    project(projectId: $projectId) {
      addSoftwareComponent(name: $name) {
        id,
        name
      }
    }
  }
}
  ''';

  static const String _setCodeManagementQuery = r'''
  mutation setCodeManagement($softwareId: Long!, $repoToolType:RepoToolType!, $repoUrl: String!, $repoToken: String) {
  user {
    softwareComponent(softwareId: $softwareId) {
      setCodeManagementTool(repoToolType: $repoToolType, repoUrl: $repoUrl, repoToken: $repoToken) {
        id
      }
    }
  }
}
  ''';

  Future<SoftwareComponent> addSoftwareComponent(
      int projectId, String name) async {
    final QueryOptions options = QueryOptions(
      document: gql(_createSoftwareQuery),
      variables: {'projectId': projectId, 'name': name},
    );

    final QueryResult result = await query(options);

    if (result.hasException) {
      return Future.error(result.exception!);
    } else {
      Map<String, dynamic> softwareJson =
          result.data!['user']['project']['addSoftwareComponent'];
      return Future.value(SoftwareComponent.fromJson(softwareJson));
    }
  }

  Future<CodeManagement> addCodeManagement(int softwareId, String gitToolType,
      String gitUrl, String? gitAccessToken) async {
    final QueryOptions options = QueryOptions(
      document: gql(_setCodeManagementQuery),
      variables: {'softwareId': softwareId, 'repoToolType': gitToolType, 'repoUrl': gitUrl, 'repoToken': gitAccessToken},
    );

    final QueryResult result = await query(options);

    if (result.hasException) {
      return Future.error(result.exception!);
    } else {
      Map<String, dynamic> codeManagementJson =
      result.data!['user']['softwareComponent']['setCodeManagementTool'];
      return Future.value(CodeManagement.fromJson(codeManagementJson));
    }
  }

  Future<void> removeCodeManagement(int softwareId) async {

  }
}
