import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hackatrix/presentation/util/preferences/preference_manager.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;
  PreferenceManager _preferences = new PreferenceManager();

  final JsonDecoder _decoder = new JsonDecoder();
  final errorMessage = "Error while fetching data";

  Future<dynamic> get(String url, {Map<String, String> headers, Map<String, dynamic> parameters}) async {
    var newHeaders = new Map<String, String>();
    String token = await _preferences.getToken();

    if (token != null) {
      newHeaders = {"Authorization": "Token $token"};
    }
    if (headers != null) newHeaders.addAll(headers);

    Uri uri = Uri.parse(url).replace(queryParameters: parameters);
    debugPrint("$url , headers: $newHeaders, params: $parameters");
    return http.get(uri.toString(), headers: newHeaders).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (response.bodyBytes.length > 0) {
        final String res = utf8.decode(response.bodyBytes);
        debugPrint(res);
        dynamic map = _decoder.convert(res);

        if (statusCode < 200 || statusCode > 401 || json == null) {
          var currentError = errorMessage;
          if (map is Map<String, dynamic> && map["detail"] != null) {
            currentError = map["detail"];
          }
          throw new Exception(currentError);
        }

        return map;
      } else {
        if (statusCode < 200 || statusCode > 401 || json == null) {
          throw new Exception(errorMessage);
        }
        return new Map();
      }
    });
  }

  Future<dynamic> post(String url, {Map<String, dynamic> headers, body, encoding}) async {
    var newHeaders = new Map<String, String>();
    String token = await _preferences.getToken();
    if (token != null) {
      newHeaders = {"Authorization": "Token $token"};
    }
    if (headers != null) newHeaders.addAll(headers);
    debugPrint("$url , headers: $newHeaders, body: $body");
    return http.post(url, body: body, headers: newHeaders, encoding: encoding).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (response.bodyBytes.length > 0) {
        final String res = utf8.decode(response.bodyBytes);
        debugPrint(res);
        dynamic map = _decoder.convert(res);

        if (statusCode < 200 || statusCode > 401 || json == null) {
          var currentError = errorMessage;
          if (map is Map<String, dynamic> && map["detail"] != null) {
            currentError = map["detail"];
          }
          throw new Exception(currentError);
        }

        return map;
      } else {
        if (statusCode < 200 || statusCode > 401 || json == null) {
          throw new Exception(errorMessage);
        }
        return new Map();
      }
    });
  }

  Future<dynamic> patch(String url, {Map<String, dynamic> headers, body, encoding}) async {
    var newHeaders = new Map<String, String>();
    String token = await _preferences.getToken();
    if (token != null) {
      newHeaders = {"Authorization": "Token $token"};
    }
    if (headers != null) newHeaders.addAll(headers);
    debugPrint("$url , headers: $newHeaders, body: $body");
    return http.patch(url, body: body, headers: newHeaders, encoding: encoding).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (response.bodyBytes.length > 0) {
        final String res = utf8.decode(response.bodyBytes);
        debugPrint(res);
        dynamic map = _decoder.convert(res);

        if (statusCode < 200 || statusCode > 401 || json == null) {
          var currentError = errorMessage;
          if (map is Map<String, dynamic> && map["detail"] != null) {
            currentError = map["detail"];
          }
          throw new Exception(currentError);
        }

        return map;
      } else {
        if (statusCode < 200 || statusCode > 401 || json == null) {
          throw new Exception(errorMessage);
        }
        return new Map();
      }
    });
  }
}
