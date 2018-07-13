import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackatrix/data/repository/user_repository.dart';
import 'package:hackatrix/presentation/profile/forgot_password/forgot_password_page.dart';
import 'package:hackatrix/presentation/util/preferences/preference_manager.dart';

import 'package:rxdart/rxdart.dart';

class LoginBloC {
  final UserRepository repository;

  final PreferenceManager _preferences = new PreferenceManager();

  PublishSubject<LoginOutput> _output = PublishSubject<LoginOutput>();

  ReplaySubject<LoginCredentials> _input = ReplaySubject<LoginCredentials>();

  // Getters
  Stream<LoginOutput> get output => _output;

  Sink<LoginCredentials> get input => _input;

  LoginBloC(this.repository) {
    _input.listen((credentials) {
      _output.add(LoginOutput(LoginOutCase.isLoading, true));

      repository.authenticate(credentials).then((token) {
        saveToken(token).then((isSaved) {
          if (isSaved) {
            _output.add(LoginOutput(LoginOutCase.token, token));
          } else {
            _output.add(
                LoginOutput(LoginOutCase.errorMessage, "Error saving Token!"));
          }
        });
      }, onError: (error) {
        _output.add(LoginOutput(LoginOutCase.errorMessage, error));
      });
    });
  }

  void dispose() {
    _input.close();
    _output.close();
  }

  Future<bool> saveToken(String token) async {
    return _preferences.saveToken(token);
  }

  String validateFieldForInput(LoginInput input, String value) {
    switch (input) {
      case LoginInput.username:
        return !value.contains('@') ? 'No es un email válido.' : null;
      case LoginInput.password:
        return value.isEmpty ? 'Contraseña no válida.' : null;
      default:
        return null;
    }
  }

  void forgotPassword(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => ForgotPasswordPage(),
      ),
    );
  }
}

class LoginCredentials {
  final String username;
  final String password;

  LoginCredentials(this.username, this.password);
}

class LoginOutput {
  final LoginOutCase loginOutCase;
  dynamic info;

  LoginOutput(this.loginOutCase, this.info);
}

enum LoginInput { username, password }

enum LoginOutCase { isLoading, token, errorMessage }
