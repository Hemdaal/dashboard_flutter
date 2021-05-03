import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Login', style: Theme.of(context).textTheme.headline4),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailFieldController,
                    decoration: InputDecoration(
                        hintText: 'Email', border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordFieldController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => {},
                  label: Text('Login'),
                  icon: Icon(Icons.login, size: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
