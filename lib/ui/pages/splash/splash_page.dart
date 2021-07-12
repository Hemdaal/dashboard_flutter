import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/ui/pages/login/login_page.dart';
import 'package:hemdaal_ui_flutter/ui/pages/projects/projects_page.dart';
import 'package:hemdaal_ui_flutter/ui/pages/splash/splash_page.bloc.dart';
import 'package:hemdaal_ui_flutter/utils/bloc.dart';
import 'package:hemdaal_ui_flutter/utils/fetch.dart';

class SplashPage extends StatelessWidget {
  static const String route = '/';

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
          stream: _bloc.userStream,
          builder: (context, snapshot) {
            Fetch<User> userFetch = Fetch.fromSnapShot(snapshot);
            if (userFetch.isSuccess()) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Navigator.of(context).pushNamed(ProjectsPage.route);
              });
            } else if (userFetch.isError()) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Navigator.of(context).pushNamed(LoginPage.route);
              });
            }
            return CircularProgressIndicator();
          }),
    ));
  }
}
