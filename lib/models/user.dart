import 'package:hemdaal_ui_flutter/adapters/project_adapter.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/create_project_info.dart';

import 'project.dart';

class User {
  final String name;
  final String email;
  final ProjectAdapter _projectAdapter;

  User(this.name, this.email, {ProjectAdapter? projectAdapter})
      : _projectAdapter = projectAdapter ?? ProjectAdapter();

  User.fromJson(Map<String, dynamic> json, {ProjectAdapter? projectAdapter})
      : name = json['name'],
        email = json['email'],
        _projectAdapter = projectAdapter ?? ProjectAdapter();

  Map<String, dynamic> toJson() => {'name': name, 'email': email};

  Future<List<Project>> getProjects() {
    return _projectAdapter.getProjects();
  }

  Future<Project> createProject(CreateProjectInfo data) async {
    final project = await _projectAdapter.createProject(data.name ?? '');
    data.getSoftwareInfos().forEach((element) async {
      await project.addSoftwareComponent(element);
    });

    return Future.value(project);
  }
}
