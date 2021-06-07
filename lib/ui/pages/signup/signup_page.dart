import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/ui/pages/projects/projects_page.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/extensions.dart';
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
    return BlocProvider(bloc: _bloc, child: _render(context));
  }

  Widget _render(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('Signup')
        ),
        body: Center(
            child: StreamBuilder<Fetch<User>>(
                stream: _bloc.getUserStream(),
                builder: (context, snapshot) {
                  if (snapshot.data?.isSuccess() == true) {
                    _navigateToProjectsPage(context, snapshot.getContent());
                    return CircularProgressIndicator();
                  } else if (snapshot.data?.isError() == true) {
                    //Also show error
                    return _getSignupForm(context);
                  } else if (snapshot.data?.isLoading() == true) {
                    return CircularProgressIndicator();
                  } else {
                    return _getSignupForm(context);
                  }
                })));
  }

  void _navigateToProjectsPage(BuildContext context, User user) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProjectsPage(user)));
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
