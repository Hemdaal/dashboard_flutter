import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:hemdaal_ui_flutter/pages/splash/splash_page.dart';

Future main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DotEnv.load(fileName: '.env'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Family Locator',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  primaryColor: Colors.blue,
                  accentColor: Colors.blue),
              home: SplashPage(),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
