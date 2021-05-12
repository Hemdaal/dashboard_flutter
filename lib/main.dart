import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:hemdaal_ui_flutter/pages/splash/splash_page.dart';

Future main() async {
  await DotEnv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hemdaal',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          accentColor: Colors.blue),
      home: SplashPage(),
    );
  }
}
