import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/ui/pages/projects/projects_page.dart';
import 'package:hemdaal_ui_flutter/ui/pages/signup/signup_page.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

import 'login_page.bloc.dart';

class LoginPage extends StatelessWidget {

  static const String route = '/login';

  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController = TextEditingController();
  final LoginPageBloc _bloc;

  LoginPage({LoginPageBloc? loginPageBloc}) : this._bloc = loginPageBloc ?? LoginPageBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(bloc: _bloc, child: _render(context));
  }

  Widget _render(BuildContext context) {
    return Scaffold(
        body: Center(
      child: StreamBuilder<Fetch<User>>(
          stream: _bloc.getUserStream(),
          builder: (context, snapshot) {
            if (snapshot.data?.isSuccess() == true) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Navigator.of(context).pushNamed(ProjectsPage.route);
              });
              return CircularProgressIndicator();
            } else if (snapshot.data?.isError() == true) {
              return _getLoginForm(context);
            } else if (snapshot.data?.isLoading() == true) {
              return CircularProgressIndicator();
            } else {
              return _getLoginForm(context);
            }
          }),
    ));
  }

  Widget _getLoginForm(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 1/4,
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Login', style: Theme.of(context).textTheme.headline4),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailFieldController,
                decoration: InputDecoration(hintText: 'Email', border: OutlineInputBorder()),
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
            ElevatedButton(
              onPressed: () => {_bloc.login(_emailFieldController.value.text, _passwordFieldController.value.text)},
              child: Text('Login', style: Theme.of(context).textTheme.bodyText2),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            OutlinedButton(
                onPressed: () =>
                    {Navigator.of(context).pushNamed(SignupPage.route)},
                child: Text("Create Account"))
          ],
        ),
      ),
    );
  }
}
