import 'package:hemdaal_ui_flutter/models/projectcreator/create_code_management_info.dart';

class CreateSoftwareInfo {
  String? name;
  CreateCodeManagementInfo? _codeManagementInfo;

  CreateCodeManagementInfo? getCodeManagementInfo() {
    return _codeManagementInfo;
  }

  bool isCodeManagementEnabled() {
    return _codeManagementInfo != null;
  }

  void enableCodeManagement() {
    this._codeManagementInfo = CreateCodeManagementInfo();
  }

  void disableCodeManagement() {
    this._codeManagementInfo = null;
  }

  bool isValid() {
    return name?.isNotEmpty == true && _codeManagementInfo?.isValid() == true;
  }
}
