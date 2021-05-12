import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/pages/projects/projects_page.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

import 'signup_page.bloc.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final SignupPageBloc _bloc;

  SignupPage({SignupPageBloc? signupPageBloc})
      : this._bloc = signupPageBloc ?? SignupPageBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: StreamBuilder<Fetch<User>>(
                stream: _bloc.getUserStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data?.isSuccess() == true) {
                    _navigateToProjectsPage(context);
                    return CircularProgressIndicator();
                  } else if (snapshot.data?.isLoading() == true) {
                    return CircularProgressIndicator();
                  } else {
                    return _getSignupForm(context);
                  }
                })));
  }

  void _navigateToProjectsPage(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProjectsPage()));
    });
  }

  Widget _getSignupForm(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Signup', style: Theme.of(context).textTheme.headline4),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameFieldController,
                decoration: InputDecoration(
                    hintText: 'Name', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailFieldController,
                decoration: InputDecoration(
                    hintText: 'Email', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                obscuringCharacter: '*',
                controller: _passwordFieldController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => {
                _bloc.signup(
                    _nameFieldController.value.text,
                    _emailFieldController.value.text,
                    _passwordFieldController.value.text)
              },
              label: Text('Signup'),
              icon: Icon(Icons.login, size: 18),
            )
          ],
        ),
      ),
    );
  }
}
