import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/event/event_page.dart';
import 'package:hackatrix/presentation/profile/login/login_page.dart';
import 'package:hackatrix/presentation/util/theme.dart';

import 'drawer_item.dart';

abstract class DrawerListener {
  void onSelectedItem(pos);

  void onUserLoggedIn(user);
}

class DrawerWidget {
  User _user;
  int _selectedDrawerIndex;
  DrawerListener _listener;

  DrawerWidget(this._listener) {
    _selectedDrawerIndex = 0;
    _user = null;
  }


  Widget _buildUserHeader(BuildContext context) {
    Widget _accountName;
    Widget _accountEmail;
    if (_user != null) {
      _accountEmail = new Text(
        _user.email,
        style: Theme.of(context).textTheme.body2.apply(
              color: Colors.white,
            ),
      );
    } else {
      _accountEmail = new RawMaterialButton(
          child: new Text(
            "Inicia sesión o Crea una cuenta",
            style: Theme.of(context).textTheme.body2.apply(
                  color: Colors.white,
                ),
          ),
          onPressed: () {
            _onOpenLogin(context);
          });
    }
    _accountName = new Text(
      _user != null ? _user.fullName : "",
      style: Theme.of(context).textTheme.headline.apply(
            color: Colors.white,
          ),
    );
    return new UserAccountsDrawerHeader(accountName: _accountName, accountEmail: _accountEmail);
  }

  Future _onOpenLogin(BuildContext context) async {
    Navigator.of(context).pop();
    User user = await Navigator.of(context).push(new MaterialPageRoute<User>(
        builder: (BuildContext context) {
          return new LoginPage();
        },
        fullscreenDialog: true));
    if (user != null) {
      _listener.onUserLoggedIn(user);
    }
  }

  _onSelectedItem(int index) {
    _selectedDrawerIndex = index;
    _listener.onSelectedItem(index);
  }

  Widget _buildHeading(BuildContext context, HeadingItem d) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Divider(),
        new Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: new Text(
            d.drawerTitle,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return new Divider();
  }

  Widget _buildItem(ListItem d, int i) {
    return new ListTile(
      leading: d.icon,
      title: new Text(d.drawerTitle),
      selected: i == _selectedDrawerIndex,
      onTap: () => _onSelectedItem(i),
    );
  }

  _listDrawerOptions(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      var view;
      if (!d.forUserLogged ||
          (d.forUserLogged && _user != null && (_user != null && d.jury && _user.isJury) ||
              (_user != null && d.moderator && _user.isModerator) ||
              (_user != null && d.staff && _user.isStaff))) {
        if (d is ListItem) {
          view = _buildItem(d, i);
        } else if (d is DividerItem) {
          view = _buildDivider();
        } else {
          view = _buildHeading(context, d);
        }
        drawerOptions.add(view);
      }
    }
    return drawerOptions;
  }

  Widget build(BuildContext context, User user) {
    _user = user;
    var drawerOptions = _listDrawerOptions(context);

    return new Drawer(
      child: new ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                color: CompanyColors.orange,
                child: _buildUserHeader(context),
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: drawerOptions,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getDrawerTitle(int pos) {
    ListItem item = drawerItems[pos];
    return item.showTitle ? item.drawerTitle : "";
  }

  Widget getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new EventPage();
      default:
        return null;
    }
  }
}
//
//  _onTapProfile() {
//    Navigator.of(context).pop();
//    Navigator.push(
//      context,
//      new MaterialPageRoute(
//        builder: (BuildContext context) => new ProfilePage(_user, _onUserLogOut),
//      ),
//    );
//  }
