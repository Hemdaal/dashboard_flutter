import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/ui/pages/projects/projects_page.dart';
import 'package:hemdaal_ui_flutter/ui/pages/signup/signup_page.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/extensions.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

import 'login_page.bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final LoginPageBloc _bloc;

  LoginPage({LoginPageBloc? loginPageBloc})
      : this._bloc = loginPageBloc ?? LoginPageBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(bloc: _bloc, child: _render(context));
  }

  Widget _render(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Login')
        ),
        body: Center(
          child: StreamBuilder<Fetch<User>>(
              stream: _bloc.getUserStream(),
              builder: (context, snapshot) {
                if (snapshot.data?.isSuccess() == true) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            ProjectsPage(snapshot.getContent())));
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
    return SizedBox(
      width: 400,
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Login', style: Theme.of(context).textTheme.headline4),
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
                _bloc.login(_emailFieldController.value.text,
                    _passwordFieldController.value.text)
              },
              label: Text('Login'),
              icon: Icon(Icons.login, size: 18),
            ),
            TextButton(
                onPressed: () => {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SignupPage()))
                    },
                child: Text("Create Account"))
          ],
        ),
      ),
    );
  }
}
