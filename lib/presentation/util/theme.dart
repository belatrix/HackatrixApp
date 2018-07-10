import 'package:flutter/material.dart';

ThemeData buildCompanyThemeData() {
  ThemeData base = ThemeData.light();
  return base.copyWith(
    brightness: Brightness.light,
    primaryColor: CompanyColors.orange,
    accentColor: CompanyColors.blue,
    primaryColorDark: CompanyColors.orange.shade700,
    backgroundColor: CompanyColors.offwhite,
    splashColor: CompanyColors.orange,
    textTheme: buildCompanyTextTheme(base.textTheme),
  );
}

TextTheme buildCompanyTextTheme(TextTheme base) {
  return base.copyWith().apply();
}

class CompanyColors {
  static const offwhite = const Color(0xF0F0F0);

  static const orangePrimaryValue = 0xFFF49926;
  static const bluePrimaryValue = 0xFF1A4F9E;

  CompanyColors._(); // this basically makes it so you can instantiate this class
  static const MaterialColor orange =
      const MaterialColor(orangePrimaryValue, const <int, Color>{
    50: const Color(0xFFFDF3E2),
    100: const Color(0xFFFBE0B6),
    200: const Color(0xFFF9CB87),
    300: const Color(0xFFF7B758),
    400: const Color(0xFFF6A739),
    500: const Color(orangePrimaryValue),
    600: const Color(0xFFF08E23),
    700: const Color(0xFFE97F20),
    800: const Color(0xFFE2701D),
    900: const Color(0xFFD7591A),
  });

  static const MaterialAccentColor blue =
      const MaterialAccentColor(bluePrimaryValue, const <int, Color>{
    50: const Color(0xFFE4F3FC),
    100: const Color(0xFFBEE1FA),
    200: const Color(0xFF96CEF7),
    300: const Color(0xFF6EBBF3),
    400: const Color(0xFF51ACF2),
    500: const Color(0xFF399EF0),
    600: const Color(0xFF3290E2),
    700: const Color(0xFF2A7ECF),
    800: const Color(0xFF256DBD),
    900: const Color(bluePrimaryValue),
  });
}

final IconThemeData companyThemeIcon = new IconThemeData(
  color: Colors.white,
);
