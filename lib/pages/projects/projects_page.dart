import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'projects_page.bloc.dart';

class ProjectsPage extends StatelessWidget {
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();
  final ProjectsPageBloc _bloc;

  ProjectsPage({ProjectsPageBloc? projectsPageBloc})
      : this._bloc = projectsPageBloc ?? ProjectsPageBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Project page'),
      ),
    );
  }
}
