import 'dart:async';

import 'package:hackatrix/domain/model/user.dart';

abstract class UserRepository {
  Future<String> authenticate(String username, String password);
  Future<User> profile(String token);
  Future<bool> logout();
}