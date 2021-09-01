import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget.dart';
import 'package:hemdaal_ui_flutter/models/dashboard/widget/dashboard_widget_type.dart';
import 'package:hemdaal_ui_flutter/ui/components/dashboardWidgets/dashboard_widget.component.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/extensions.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

import 'project_dashboard_page.bloc.dart';

class ProjectDashboardPage extends StatelessWidget {
  final int _projectId;

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

  ProjectDashboardPage(this._projectId, {ProjectDashboardPageBloc? projectsPageBloc})
      : this._bloc = projectsPageBloc ?? ProjectDashboardPageBloc(_projectId);

  @override
  Widget build(BuildContext context) {
    _bloc.getDashboardWidgets();
    return BlocProvider(bloc: _bloc, child: _render(context));
  }

  @override
  Widget _render(BuildContext context) {
    return Scaffold(
      body: Center(
          child: StreamBuilder<Fetch<List<DashboardWidget>>>(
              stream: _bloc.getDashboardWidgetsStream(),
              builder: (context, snapshot) {
                if (snapshot.data?.isSuccess() == true) {
                  return _showDashboardWidgets(context, snapshot.getContent());
                } else if (snapshot.data?.isError() == true) {
                  return _showFailure(context);
                } else {
                  return CircularProgressIndicator();
                }
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Choose Widget Type'),
                  content: _setupAlertDialoadContainer(),
                );
              });
        },
        icon: Icon(Icons.add),
        label: Text('Add Widget'),
      ),
    );
  }

  Widget _setupAlertDialoadContainer() {
    List<DashboardWidgetType> widgetTypes = DashboardWidgetType.values;
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widgetTypes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(widgetTypes[index].name),
            onTap: () {
              this._bloc.addWidget(widgetTypes[index]);
            },
          );
        },
      ),
    );
  }

  Widget _showDashboardWidgets(BuildContext context, List<DashboardWidget> dashboardWidgets) {
    if (dashboardWidgets.isEmpty) {
      return Text('No widgets found');
    } else {
      final List<Widget> widgets = [];
      dashboardWidgets.forEach((dashboardWidget) {
        widgets.add(DashboardWidgetComponent(dashboardWidget));
      });
      return SizedBox(
          width: 500,
          child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: (2 / 1),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: widgets,
              padding: const EdgeInsets.all(20.0)));
    }
  }

  Widget _showFailure(BuildContext context) {
    return TextButton(child: Text('Please try again'), onPressed: () => _bloc.getDashboardWidgets());
  }
}
