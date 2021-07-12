import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';

import 'project_dashboard_page.bloc.dart';

class ProjectDashboardPage extends StatelessWidget {
  static String createRoute(int projectId) {
    return 'projects/${projectId.toString()}/dashboard';
  }

  static bool isMatchingPath(String path) {
    var uri = Uri.parse(path);
    return uri.pathSegments.length == 3 && uri.pathSegments[0] == 'projects' && uri.pathSegments[2] == 'dashboard';
  }

  static int? parseProjectId(String path) {
    var uri = Uri.parse(path);
    return int.tryParse(uri.pathSegments[1]);
  }

  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();
  final ProjectDashboardPageBloc _bloc;

  ProjectDashboardPage(int projectId, {ProjectDashboardPageBloc? projectsPageBloc})
      : this._bloc = projectsPageBloc ?? ProjectDashboardPageBloc(projectId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(bloc: _bloc, child: _render(context));
  }

  @override
  Widget _render(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Project'),
    ));
  }
}
