import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackatrix/presentation/home/home_page.dart';
import 'package:hackatrix/presentation/util/theme.dart' as theme;

void main() => runApp(new HackatrixApp());

class HackatrixApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    config();
    return new MaterialApp(
      home:  new HomePage(),
      theme: theme.companyThemeData,
    );
  }

  void config() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
