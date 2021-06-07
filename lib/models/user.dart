import 'package:hemdaal_ui_flutter/adapters/project_adapter.dart';

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
}
