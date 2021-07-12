import 'package:graphql/client.dart';
import 'package:hemdaal_ui_flutter/adapters/base_adapter.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:hemdaal_ui_flutter/utils/console_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAdapter extends BaseNetworkAdapter {
  static const String _login = r'''
  query Login($email: String!, $password: String!) {
    login(email: $email, password: $password) {
      token
    }
  }
  ''';

  static const String _register = r'''
  query CreateUser($name: String!, $email: String!, $password: String!) {
    createUser(name: $name, email: $email, password: $password) {
      token
    }
  }
  ''';

  static const String _user = r'''
  query User() {
      user {
        name,
        email
      }
  }
  ''';

  Future<User> login(String email, String password) async {
    final QueryOptions options = QueryOptions(
      document: gql(_login),
      variables: {'email': email, 'password': password},
    );

    final QueryResult result = await query(options);

    if (result.hasException) {
      return Future.error(result.exception!);
    } else {
      String token = result.data!['login']['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return await getUser();
    }
  }

  Future<User> getUser() async {
    final QueryOptions options = QueryOptions(document: gql(_user));
    final QueryResult result = await query(options);

    if (result.hasException) {
      throw result.exception ?? Exception();
    } else {
      return User.fromJson(result.data!['user']);
    }
  }

  Future<User> register(String name, String email, String password) async {
    final QueryOptions options = QueryOptions(
      document: gql(_register),
      variables: {'name': name, 'email': email, 'password': password},
    );

    final QueryResult result = await query(options);

    if (result.hasException) {
      print(result.exception);
      return Future.error(result.exception!);
    } else {
      String token = result.data!['createUser']['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return await getUser();
    }
  }
}
