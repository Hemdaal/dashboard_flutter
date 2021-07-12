import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/create_project_info.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/ui/pages/createProject/add_software_widget.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/console_log.dart';

import 'create_project_bloc.dart';

class CreateProjectPage extends StatelessWidget {
  final CreateProjectBloc _bloc;

  CreateProjectPage({CreateProjectBloc? createProjectBloc})
      : _bloc = createProjectBloc ?? CreateProjectBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(bloc: _bloc, child: _render(context));
  }

  Widget _render(BuildContext context) {
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
                return SizedBox(
                    width: 400,
                    child: Form(
                        child: Column(
                      children: [
                        Text('Create Project',
                            style: Theme.of(context).textTheme.headline4),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (name) => {
                                createProjectInfo.name = name,
                                _bloc.update(createProjectInfo)
                              },
                              initialValue: createProjectInfo.name,
                              decoration: InputDecoration(
                                  hintText: 'Project Name',
                                  border: OutlineInputBorder()),
                            )),
                        _showSoftwareComponents(createProjectInfo),
                        OutlinedButton.icon(
                          onPressed: () {
                            createProjectInfo.addSoftwareComponent();
                            _bloc.update(createProjectInfo);
                          },
                          icon: Icon(Icons.add, size: 18),
                          label: Text("Add Software"),
                        ),
                        ElevatedButton.icon(
                          onPressed: _onCreateProject(snapshot.data!),
                          label: Text('Create'),
                          icon: Icon(Icons.add, size: 18),
                        )
                      ],
                    )));
              }),
        ));
  }

  Widget _showSoftwareComponents(
    CreateProjectInfo createProjectInfo,
  ) {
    List<Widget> widgets = List.empty(growable: true);

    createProjectInfo.getSoftwareInfos().forEach((element) {
      widgets.add(AddSoftwareWidget(
          element, (value) => {_bloc.update(createProjectInfo)}));
    });

    return Column(
      children: widgets,
    );
  }

  _onCreateProject(CreateProjectInfo data) {
    if (data.isValid() && !data.isLoading()) {
      return () => {
        _bloc.createProject(data)
      };
    }

    return null;
  }
}
