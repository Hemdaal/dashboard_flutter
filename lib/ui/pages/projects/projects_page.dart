import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/project.dart';
import 'package:hemdaal_ui_flutter/ui/pages/createProject/create_project_page.dart';
import 'package:hemdaal_ui_flutter/ui/pages/projectDashboard/project_dashboard_page.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/extensions.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

import 'projects_page.bloc.dart';

class ProjectsPage extends StatelessWidget {
  static const String route = '/projects';

  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();
  final ProjectsPageBloc _bloc;

  ProjectsPage({ProjectsPageBloc? projectsPageBloc}) : this._bloc = projectsPageBloc ?? ProjectsPageBloc();

  @override
  Widget build(BuildContext context) {
    _bloc.getProjects();
    return BlocProvider(bloc: _bloc, child: _render(context));
  }

  @override
  Widget _render(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Projects'),
        actions: [
          Icon(Icons.person),
        ],
      ),
      body: Center(
        child: StreamBuilder<Fetch<List<Project>>>(
          stream: _bloc.getUserStream(),
          builder: (context, snapshot) {
            if (snapshot.data?.isSuccess() == true) {
              return _showProjects(context, snapshot.getContent());
            } else if (snapshot.data?.isError() == true) {
              return _showFailure(context);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateProjectPage.route);
        },
        icon: Icon(Icons.add),
        label: Text('Create Project'),
      ),
    );
  }

  Widget _showProjects(BuildContext context, List<Project> projects) {
    if (projects.isEmpty) {
      return Text('No projects found');
    } else {
      final List<Widget> widgets = [];
      projects.forEach((project) {
        widgets.add(ListTile(
          title: Text(project.name),
          onTap: () => {Navigator.of(context).pushNamed(ProjectDashboardPage.createRoute(project.id))},
        ));
      });
      return SizedBox(width: 500, child: ListView(children: widgets, padding: const EdgeInsets.all(20.0)));
    }
  }

  Widget _showFailure(BuildContext context) {
    return TextButton(child: Text('Please try again'), onPressed: () => _bloc.getProjects());
  }
}
