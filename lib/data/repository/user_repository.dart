import 'dart:async';

import 'package:hackatrix/domain/model/user_authentication.dart';
import 'package:hackatrix/domain/model/user.dart';

abstract class UserRepository {
  Future<UserAuthentication> authenticate(String username, String password);

  Future<bool> create(String email);

  Future<bool> logout();

  Future<User> profile(String token);

  Future<bool> recoverPassword(String email);

  Future<User> userUpdate(String token, String fullName, String phoneNumber, int roleId);

  Future<User> userUpdatePassword(String currentPassword, String newPassword);
}
