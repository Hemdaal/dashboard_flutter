import 'package:flutter/material.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/ui/pages/projects/projects_page.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/extensions.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

import 'signup_page.bloc.dart';

class SignupPage extends StatelessWidget {
  static const String route = '/register';

  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController = TextEditingController();

  final SignupPageBloc _bloc;

  SignupPage({SignupPageBloc? signupPageBloc}) : this._bloc = signupPageBloc ?? SignupPageBloc();

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
      Navigator.of(context).pushNamed(ProjectsPage.route);
    });
  }

  Widget _getSignupForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 1/4,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Signup', style: Theme.of(context).textTheme.headline4),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameFieldController,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Enter Name';
                  }

                  return null;
                },
                decoration: InputDecoration(hintText: 'Name', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailFieldController,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Enter Email address';
                  }

                  return null;
                },
                decoration: InputDecoration(hintText: 'Email', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                obscuringCharacter: '*',
                obscureText: true,
                controller: _passwordFieldController,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Enter Password';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => {
                if (_formKey.currentState!.validate())
                  {
                    _bloc.signup(_nameFieldController.value.text, _emailFieldController.value.text,
                        _passwordFieldController.value.text)
                  }
              },
              child: Text('Signup'),
            )
          ],
        ),
      ),
    );
  }
}
