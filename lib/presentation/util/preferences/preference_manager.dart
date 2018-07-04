import 'dart:async';
import 'dart:convert';

import 'package:hackatrix/domain/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  // next three lines makes this class a Singleton
  static PreferenceManager _instance = new PreferenceManager.internal();
  PreferenceManager.internal();
  factory PreferenceManager() => _instance;
  final JsonEncoder _encoder = new JsonEncoder();
  final JsonDecoder _decoder = new JsonDecoder();

  static const String PREF_USER = "pref_user";
  static const String PREF_TOKEN = "pref_token";

  Future<bool> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(PREF_USER, _encoder.convert(user));
  }

  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null  && prefs.getKeys().contains(PREF_USER)) {
      String data = prefs.getString(PREF_USER);
      return User.fromJson(_decoder.convert(data));
    } else {
      return null;
    }
  }

  Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(PREF_TOKEN, token);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null && prefs.getKeys().contains(PREF_TOKEN)) {
      return prefs.getString(PREF_TOKEN);
    } else {
      return null;
    }
  }

  Future<bool> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
