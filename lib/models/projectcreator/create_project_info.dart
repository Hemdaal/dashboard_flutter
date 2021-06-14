import 'package:hemdaal_ui_flutter/models/projectcreator/create_software_info.dart';
import 'package:hemdaal_ui_flutter/utils/console_log.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class CreateProjectInfo {
  String? name;
  List<CreateSoftwareInfo> _createSoftwareInfoList = List.empty(growable: true);
  Fetch<int>? _createProjectStatus;

  void addSoftwareComponent() {
    _createSoftwareInfoList.add(CreateSoftwareInfo());
  }

  void removeSoftwareComponent(int pos) {
    _createSoftwareInfoList.removeAt(pos);
  }

  List<CreateSoftwareInfo> getSoftwareInfos() {
    return _createSoftwareInfoList.toList(growable: false);
  }

  bool isValid() {
    return name?.isNotEmpty == true && _createSoftwareInfoList.isNotEmpty && _createSoftwareInfoList.fold(true, (previousValue, element) => previousValue && element.isValid());
  }

  setCreating() {
    _createProjectStatus = Fetch.setFetching();
  }

  setProjectCreated(int projectId) {
    _createProjectStatus = Fetch.setContent(projectId);
  }

  setError(error) {
    _createProjectStatus = Fetch.setError();
  }

  bool isLoading() {
    return _createProjectStatus?.isLoading() == true;
  }
}
