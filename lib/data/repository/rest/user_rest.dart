import 'dart:async';

import 'package:hackatrix/data/repository/user_repository.dart';
import 'package:hackatrix/data/repository/util/api.dart';
import 'package:hackatrix/data/repository/util/network_util.dart';
import 'package:hackatrix/domain/model/user.dart';

class UserRest implements UserRepository {

  NetworkUtil _netUtil = new NetworkUtil();

  @override
  Future<String> authenticate(String username, String password){
    return _netUtil.post(API_USER_AUTHENTICATE, body: {"username": username, "password": password}).then((dynamic response) {
      String token = response['token'];
      if (token != null && token.isNotEmpty){
        return token;
      }
      throw new Exception("Email/Contraseña incorrectos");
    });
  }

  @override
  Future<User> profile(String token) {
   return _netUtil.get(API_USER_PROFILE, headers: {"Authorization" : "Token $token"}).then((dynamic response) {
      Map<String, dynamic> data = response as Map<String, dynamic>;
      return User.fromJson(data['user']);
    });
  }

  @override
    Future<bool> logout() {
       return _netUtil.post(API_USER_LOGOUT).then((dynamic response) {
          return true;
       });
    }
}