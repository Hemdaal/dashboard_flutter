import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/project.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

import 'create_project_bloc.dart';

class CreateProjectPage extends StatelessWidget {
  final TextEditingController _nameFieldController = TextEditingController();

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
        child: StreamBuilder<Fetch<Project>>(
            stream: _bloc.getProjectStream(),
            builder: (context, snapshot) {
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
                          controller: _nameFieldController,
                          decoration: InputDecoration(
                              hintText: 'Project Name',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          // Respond to button press
                        },
                        icon: Icon(Icons.add, size: 18),
                        label: Text("Add Software"),
                      )                     ,
                      ElevatedButton.icon(
                        onPressed: () => {},
                        label: Text('Create'),
                        icon: Icon(Icons.add, size: 18),
                      )
                    ],
                  )));
            }),
      ),
    );
  }
}
