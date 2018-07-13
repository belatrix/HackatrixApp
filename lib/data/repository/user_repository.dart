import 'dart:async';

import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/profile/login/bloc/authenticate/login_bloc.dart';

abstract class UserRepository {
  Future<String> authenticate(LoginCredentials credentials);
  Future<User> profile(String token);
  Future<bool> logout();
}