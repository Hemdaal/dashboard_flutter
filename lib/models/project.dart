import 'package:hemdaal_ui_flutter/adapters/software_adapter.dart';
import 'package:hemdaal_ui_flutter/models/SoftwareComponent.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/create_software_info.dart';

class Project {
  final int id;
  final String name;
  final SoftwareAdapter _softwareAdapter;

  Project(this.id, this.name, {SoftwareAdapter? softwareAdapter})
      : _softwareAdapter = softwareAdapter ?? SoftwareAdapter();

  Project.fromJson(Map<String, dynamic> json,
      {SoftwareAdapter? softwareAdapter})
      : id = json['id'],
        name = json['name'],
        _softwareAdapter = softwareAdapter ?? SoftwareAdapter();

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  Future<SoftwareComponent> addSoftwareComponent(CreateSoftwareInfo element) async {
    SoftwareComponent softwareComponent = await _softwareAdapter.addSoftwareComponent(id, element.name ?? '');
    await softwareComponent.update(element);
    return softwareComponent;
  }
}
