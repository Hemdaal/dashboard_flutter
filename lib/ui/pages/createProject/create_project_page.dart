import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/create_project_info.dart';
import 'package:hemdaal_ui_flutter/ui/pages/createProject/add_software_widget.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/console_log.dart';

import 'create_project_bloc.dart';

class CreateProjectPage extends StatelessWidget {
  static const String route = '/projects/create';

  final CreateProjectBloc _bloc;

  CreateProjectPage({CreateProjectBloc? createProjectBloc}) : _bloc = createProjectBloc ?? CreateProjectBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(bloc: _bloc, child: _render(context));
  }

  Widget _render(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Create Project'),
          actions: [
            Icon(Icons.person),
          ],
        ),
        body: Center(
          child: StreamBuilder<CreateProjectInfo>(
              stream: _bloc.getCreateProjectInfoStream(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Text('Loading');
                }
                CreateProjectInfo createProjectInfo = snapshot.data!;
                return SingleChildScrollView(
                    child: SizedBox(
                        width: screenSize.width * 1 / 4,
                        child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Padding(padding: EdgeInsets.all(16.0)),
                                Text('Create Project', style: Theme.of(context).textTheme.headline4),
                                Padding(padding: EdgeInsets.all(16.0)),
                                TextFormField(
                                  onChanged: (name) => {createProjectInfo.name = name, _bloc.update(createProjectInfo)},
                                  initialValue: createProjectInfo.name,
                                  validator: (value) {
                                    if (value?.isEmpty == true) {
                                      return 'Enter project name';
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(hintText: 'Project Name', border: OutlineInputBorder()),
                                ),
                                Padding(padding: EdgeInsets.all(16.0)),
                                _showSoftwareComponents(createProjectInfo),
                                Padding(padding: EdgeInsets.all(16.0)),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    createProjectInfo.addSoftwareComponent();
                                    _bloc.update(createProjectInfo);
                                  },
                                  icon: Icon(Icons.add, size: 18),
                                  label: Text("Add Software"),
                                ),
                                Padding(padding: EdgeInsets.all(16.0)),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      _onCreateProject(snapshot.data!);
                                    }
                                  },
                                  label: Text('Create'),
                                  icon: Icon(Icons.add, size: 18),
                                )
                              ],
                            ))));
              }),
        ));
  }

  Widget _showSoftwareComponents(
    CreateProjectInfo createProjectInfo,
  ) {
    List<Widget> widgets = List.empty(growable: true);

    createProjectInfo.getSoftwareInfos().forEach((element) {
      widgets.add(AddSoftwareWidget(element, (value) => {_bloc.update(createProjectInfo)}));
      widgets.add(Padding(padding: EdgeInsets.all(8.0)));
    });

    return Column(
      children: widgets,
    );
  }

  _onCreateProject(CreateProjectInfo data) {
    if (data.isValid() && !data.isLoading()) {
        _bloc.createProject(data);
    }
  }
}
