import 'package:flutter/material.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/home/home_presenter.dart';
import 'package:hackatrix/presentation/menu/drawer_widget.dart';
import 'package:hackatrix/presentation/util/theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeView, DrawerListener {
  HomePresenter _presenter;
  User _user;
  DrawerWidget _drawer;
  int _selectedDrawerIndex;

  _HomePageState() {
    _presenter = new HomePresenter(this);
    _drawer = new DrawerWidget(this);
    _user = null;
    _selectedDrawerIndex = 0;
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadUser();
  }

  @override
  void onUserLoaded(user) {
    setState(() {
      _user = user;
    });
  }

  @override
  void onUserLoggedIn(user) {
    setState(() {
      _user = user;
    });
  }

  @override
  void onSelectedItem(pos) {
    setState(() {
      _selectedDrawerIndex = pos;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          _drawer.getDrawerTitle(_selectedDrawerIndex),
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: companyThemeIcon,
        elevation: 0.0,
      ),
      drawer: _drawer.build(context, _user),
      body: _drawer.getDrawerItemWidget(
        _selectedDrawerIndex,
      ),
    );
  }
}
