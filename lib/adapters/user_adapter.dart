import 'package:graphql/client.dart';
import 'package:hemdaal_ui_flutter/adapters/base_adapter.dart';
import 'package:hemdaal_ui_flutter/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAdapter extends BaseNetworkAdapter {
  static const String _login = r'''
  query Login($email: String!, $password: String!) {
    action: login(input: {email: $email, password: $password}) {
      user {
        name,
        email
      }
    }
  }
  ''';

  static const String _me = r'''
  query Me() {
    action: me() {
      user {
        name,
        email
      }
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
      String token = result.data!['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return User.fromJson(result.data!);
    }
  }

  Future<User> getUser() async {
    final QueryOptions options = QueryOptions(document: gql(_me));

    final QueryResult result = await query(options);

    if (result.hasException) {
      return Future.error(result.exception!);
    } else {
      return User.fromJson(result.data!);
    }
  }
}
