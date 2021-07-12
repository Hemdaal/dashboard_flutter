import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:hemdaal_ui_flutter/ui/pages/login/login_page.dart';
import 'package:hemdaal_ui_flutter/ui/pages/projects/projects_page.dart';
import 'package:hemdaal_ui_flutter/ui/pages/signup/signup_page.dart';

import 'ui/pages/splash/splash_page.dart';

Future main() async {
  await DotEnv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hemdaal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),
      initialRoute: '/',
      routes: {
        LoginPage.route: (context) => LoginPage(),
        SignupPage.route: (context) => SignupPage(),
        ProjectsPage.route: (context) => ProjectsPage(),
        SplashPage.route: (context) => SplashPage(),
      }
    );
  }
}
