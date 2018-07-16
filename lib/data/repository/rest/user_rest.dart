import 'dart:async';

import 'package:hackatrix/data/repository/user_repository.dart';
import 'package:hackatrix/data/repository/util/api.dart';
import 'package:hackatrix/data/repository/util/network_util.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/domain/model/user_authentication.dart';

class UserRest implements UserRepository {
  NetworkUtil _netUtil = new NetworkUtil();

  @override
  Future<UserAuthentication> authenticate(String username, String password) {
    return _netUtil
        .post(API_USER_AUTHENTICATE, body: {"username": username, "password": password}).then((dynamic response) {
      Map<String, dynamic> data = response as Map<String, dynamic>;
      return UserAuthentication.fromJson(data);
    });
  }

  @override
  Future<bool> create(String email) {
    return _netUtil.post(API_USER_CREATE, body: {"email": email}).then((dynamic response) {
      return true;
    }).catchError((onError) {
      return false;
    });
  }

  @override
  Future<bool> logout() {
    return _netUtil.post(API_USER_LOGOUT).then((dynamic response) {
      return true;
    });
  }

  @override
  Future<User> profile(String token) {
    return _netUtil.get(API_USER_PROFILE, headers: {"Authorization": "Token $token"}).then((dynamic response) {
      Map<String, dynamic> data = response as Map<String, dynamic>;
      return User.fromJson(data['user']);
    });
  }

  @override
  Future<bool> recoverPassword(String email) {
    return _netUtil.post(API_USER_RECOVER, body: {"email": email}).then((dynamic response) {
      return true;
    }).catchError(() {
      return false;
    });
  }

  @override
  Future<User> userUpdate(String token, String fullName, String phoneNumber, int roleId) {
    return null;
  }

  @override
  Future<User> userUpdatePassword(String currentPassword, String newPassword) {
    return _netUtil.patch(API_USER_UPDATE_PASSWORD,
        body: {"current_password": currentPassword, "new_password": newPassword}).then((dynamic response) {
      Map<String, dynamic> data = response as Map<String, dynamic>;
      return User.fromJson(data);
    });
  }
}
