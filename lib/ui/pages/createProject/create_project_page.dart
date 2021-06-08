import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/create_project_info.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/create_software_info.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';

import 'create_project_bloc.dart';

class CreateProjectPage extends StatelessWidget {
  final CreateProjectBloc _bloc;

  CreateProjectPage(User user, {CreateProjectBloc? createProjectBloc})
      : _bloc = createProjectBloc ?? CreateProjectBloc(user);

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
                        _showSoftwareComponents(
                            createProjectInfo.getSoftwareInfos()),
                        OutlinedButton.icon(
                          onPressed: () {
                            createProjectInfo.addSoftwareComponent();
                            _bloc.update(createProjectInfo);
                          },
                          icon: Icon(Icons.add, size: 18),
                          label: Text("Add Software"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => {},
                          label: Text('Create'),
                          icon: Icon(Icons.add, size: 18),
                        )
                      ],
                    )));
              }),
        ));
  }

  Widget _showSoftwareComponents(List<CreateSoftwareInfo> softwareInfos) {
    List<Widget> widgets = List.empty(growable: true);

    softwareInfos.forEach((element) {
      widgets.add(Row(children: [
        Checkbox(
            value: element.isCodeManagementEnabled(),
            onChanged: (enabled) => {
                  if (enabled == true)
                    {element.enableCodeManagement()}
                  else
                    {element.disableCodeManagement()}
                })
      ]));
    });

    return Column(
      children: widgets,
    );
  }
}
