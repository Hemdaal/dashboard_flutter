import 'package:hemdaal_ui_flutter/adapters/user_adapter.dart';

import 'user.dart';

class System {
  final UserAdapter _userAdapter;

  System({UserAdapter? userAdapter})
      : _userAdapter = userAdapter ?? UserAdapter();

  Future<User> getUser() {
    return _userAdapter.getUser();
  }

  Future<User> login(String email, String password) async {
    return _userAdapter.login(email, password);
  }

  Future<User> register(String name, String email, String password) async {
    return _userAdapter.register(name, email, password);
  }
}
