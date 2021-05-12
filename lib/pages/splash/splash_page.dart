import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/pages/login/login_page.dart';
import 'package:hemdaal_ui_flutter/pages/splash/splash_page.bloc.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class SplashPage extends StatelessWidget {
  final SplashPageBloc _bloc;

  SplashPage({SplashPageBloc? splashPageBloc})
      : this._bloc = splashPageBloc ?? SplashPageBloc();

  @override
  Widget build(BuildContext context) {
    _bloc.getUser();
    return BlocProvider(bloc: _bloc, child: _render(context));
  }

  Widget _render(BuildContext context) {
    return Scaffold(
        body: Center(
      child: StreamBuilder<Fetch<User>>(
          stream: _bloc.getUserStream(),
          builder: (context, snapshot) {
            if (snapshot.data?.isSuccess() == true) {
              //Go to dashboard or create project.
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              });
            }
            return CircularProgressIndicator();
          }),
    ));
  }
}
