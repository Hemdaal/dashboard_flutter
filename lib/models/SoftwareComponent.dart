import 'package:hemdaal_ui_flutter/adapters/software_adapter.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/create_software_info.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/git_tool_type.dart';

class SoftwareComponent {
  final int id;
  final String name;
  final SoftwareAdapter _softwareAdapter;

  SoftwareComponent(this.id, this.name, {SoftwareAdapter? softwareAdapter})
      : _softwareAdapter = softwareAdapter ?? SoftwareAdapter();

  SoftwareComponent.fromJson(Map<String, dynamic> json,
      {SoftwareAdapter? softwareAdapter})
      : id = json['id'],
        name = json['name'],
        _softwareAdapter = softwareAdapter ?? SoftwareAdapter();

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  Future<void> update(CreateSoftwareInfo element) async {
    if (element.isCodeManagementEnabled()) {
      final createCodeManagementInfo = element.getCodeManagementInfo()!;
      await _softwareAdapter.addCodeManagement(id, createCodeManagementInfo.gitTool!.name!, createCodeManagementInfo.gitUrl!, createCodeManagementInfo.gitAccessToken);
    } else {
      await _softwareAdapter.removeCodeManagement(id);
    }

    return Future.value();
  }
}
