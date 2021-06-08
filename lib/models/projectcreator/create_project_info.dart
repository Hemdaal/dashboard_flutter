import 'package:hemdaal_ui_flutter/models/projectcreator/create_software_info.dart';

class CreateProjectInfo {
  String? name;
  List<CreateSoftwareInfo> _createSoftwareInfoList = List.empty(growable: true);

  void addSoftwareComponent() {
    _createSoftwareInfoList.add(CreateSoftwareInfo());
  }

  void removeSoftwareComponent(int pos) {
    _createSoftwareInfoList.removeAt(pos);
  }

  List<CreateSoftwareInfo> getSoftwareInfos() {
    return _createSoftwareInfoList.toList(growable: false);
  }
}
