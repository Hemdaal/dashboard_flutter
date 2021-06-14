import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/create_software_info.dart';
import 'package:hemdaal_ui_flutter/models/projectcreator/git_tool_type.dart';

class AddSoftwareWidget extends StatelessWidget {
  final CreateSoftwareInfo _softwareInfo;
  final ValueChanged _onValueChanged;

  AddSoftwareWidget(
      CreateSoftwareInfo softwareInfo, ValueChanged onValueChanged)
      : this._softwareInfo = softwareInfo,
        this._onValueChanged = onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onChanged: (name) =>
              {_softwareInfo.name = name, _onValueChanged(_softwareInfo)},
          initialValue: _softwareInfo.name,
          decoration: InputDecoration(
              hintText: 'Software Name', border: OutlineInputBorder()),
        ),
        _getCodeManagementWidget()
      ],
    );
  }

  Widget _getCodeManagementWidget() {

    final columns = List<Widget>.empty(growable: true);

    columns.add(Row(children: [
      Checkbox(
          value: _softwareInfo.isCodeManagementEnabled(),
          onChanged: (enabled) => {
            if (enabled == true)
              {
                _softwareInfo.enableCodeManagement(),
                _onValueChanged(_softwareInfo)
              }
            else
              {
                _softwareInfo.disableCodeManagement(),
                _onValueChanged(_softwareInfo)
              }
          }),
      Text('Code Management')
    ]));

    if(_softwareInfo.isCodeManagementEnabled()) {
      columns.add(_createCodeMangementWidget());
    }

    return Column(children: columns);
  }

  Widget _createCodeMangementWidget() {
    return Column(children: [
      DropdownButton<GitToolType>(
        items: GitToolType.values.map((GitToolType value) {
          return DropdownMenuItem<GitToolType>(
            value: value,
            child: new Text(value.toString()),
          );
        }).toList(),
        value: _softwareInfo.getCodeManagementInfo()?.gitTool,
        onChanged: (tool) {
          _softwareInfo.getCodeManagementInfo()?.gitTool = tool;
          _onValueChanged(_softwareInfo);
        },
      ),
      TextFormField(
        onChanged: (url) =>
        {_softwareInfo.getCodeManagementInfo()?.gitUrl = url, _onValueChanged(_softwareInfo)},
        initialValue: _softwareInfo.getCodeManagementInfo()?.gitUrl,
        decoration: InputDecoration(
            hintText: 'URL', border: OutlineInputBorder()),
      ),
      TextFormField(
        onChanged: (accessToken) =>
        {_softwareInfo.getCodeManagementInfo()?.gitAccessToken = accessToken, _onValueChanged(_softwareInfo)},
        initialValue: _softwareInfo.getCodeManagementInfo()?.gitAccessToken,
        decoration: InputDecoration(
            hintText: 'Token', border: OutlineInputBorder()),
      ),
    ],);
  }
}
