import 'package:hemdaal_ui_flutter/models/projectcreator/git_tool_type.dart';

class CreateCodeManagementInfo {
  GitToolType? gitTool;
  String? gitUrl;
  String? gitAccessToken;

  isValid() {
    return gitTool != null && gitUrl != null;
  }
}
