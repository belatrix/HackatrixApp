import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackatrix/data/repository/rest/event_rest.dart';
import 'package:hackatrix/presentation/home/bloc/home_bloc.dart';
import 'package:hackatrix/presentation/home/bloc/home_page_2.dart';
import 'package:hackatrix/presentation/home/bloc/home_provider.dart';
import 'package:hackatrix/presentation/util/theme.dart' as theme;

void main() => runApp(new HackatrixApp());

class HackatrixApp extends StatelessWidget {
  Widget build(BuildContext context) {
    config();
    return MaterialApp(
      home:
          HomeProvider(homeBloc: HomeBloc(EventRest()), child: HomePage2(true)),
      theme: theme.CompanyThemeData,
    );
  }

  void config() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
