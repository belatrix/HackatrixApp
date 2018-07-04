import 'package:flutter/material.dart';

final ThemeData CompanyThemeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.orange,
  primaryColor: CompanyColors.blue[500],
  primaryColorBrightness: Brightness.light,
  accentColor: CompanyColors.green[500],
  accentColorBrightness: Brightness.light
);

final IconThemeData CompanyThemeIcon = new IconThemeData(
  color: Colors.white,
);

class CompanyColors {
  CompanyColors._(); // this basically makes it so you can instantiate this class
  static const Map<int, Color> blue = const <int, Color> {
    //50: const Color(/* some hex code */),
    //100: const Color(/* some hex code */),
    //200: const Color(/* some hex code */),
  };
  
  static const Map<int, Color> green = const <int, Color> {
    //50: const Color(/* some hex code */),
    //100: const Color(/* some hex code */),
  };
}