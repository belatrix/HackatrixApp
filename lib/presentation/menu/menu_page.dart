import 'package:flutter/material.dart';
import 'package:hackatrix/data/repository/rest/user_rest.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/admin/event_list_page.dart';
import 'package:hackatrix/presentation/profile/login/bloc/authenticate/login_bloc.dart';
import 'package:hackatrix/presentation/profile/login/bloc/authenticate/login_provider.dart';
import 'package:hackatrix/presentation/profile/login/bloc/login_page_2.dart';
import 'package:hackatrix/presentation/profile/login/login_page.dart';
import 'package:hackatrix/presentation/profile/my_profile/profile_page.dart';
import 'package:hackatrix/presentation/util/preferences/preference_manager.dart';

class MenuSidePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  MenuSidePage(this._scaffoldKey);

  @override
  _MenuSidePageState createState() => new _MenuSidePageState();
}

class _MenuSidePageState extends State<MenuSidePage> {
  User _user;
  PreferenceManager _preferences = new PreferenceManager();

  _onTapLogin() {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => LoginProvider(
            loginBloc: LoginBloC(UserRest()), child: LoginPage2(_onUserLogged)),
      ),
    );
  }

  _onTapProfile() {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) =>
            new ProfilePage(_user, _onUserLogOut),
      ),
    );
  }

  _onTapAdmin() {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new EventListPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  _loadUser() {
    _preferences.getUser().then((user) {
      setState(() {
        _user = user;
      });
    });
  }

  _onUserLogged() {
    widget._scaffoldKey.currentState.openDrawer();
  }

  _onUserLogOut() {
    //widget._scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    var listItems = new List<Widget>();
    listItems.add(new Container(
      color: Colors.orange,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          new Image.asset("images/hackatrix_logo.png"),
          buildUserHeader(),
        ],
      ),
    ));

    var subItems = new List<Widget>();
    if (_user != null) {
      subItems.add(createHeaderWithPadding(new Text("Perfil")));
      subItems.add(new FlatButton.icon(
        icon: new Icon(Icons.person),
        label: new Text(
          "Perfil",
          style: TextStyle(color: Colors.blueGrey),
        ),
        onPressed: () => _onTapProfile(),
      ));

      subItems.add(createHeaderWithPadding(new Text("Admin")));
      subItems.add(new FlatButton.icon(
        icon: new Icon(Icons.settings),
        label: new Text(
          "Admin",
          style: TextStyle(color: Colors.blueGrey),
        ),
        onPressed: () => _onTapAdmin(),
      ));
    } else {
      subItems.add(Text("No options",
          style: new TextStyle(
            color: Colors.white,
          )));
    }

    var container = new Container(
      margin: EdgeInsets.all(15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: subItems,
      ),
    );

    listItems.add(container);

    return new ListView(
      padding: EdgeInsets.all(0.0),
      children: listItems,
    );
  }

  Widget buildUserHeader() {
    if (_user != null) {
      return new Column(
        children: <Widget>[
          new ListTile(
            title: new Text(_user.fullName,
                style: new TextStyle(
                  color: Colors.white,
                )),
            subtitle: new Text(_user.email,
                style: new TextStyle(
                  color: Colors.white,
                )),
          )
        ],
      );
    } else {
      return new RawMaterialButton(
        textStyle: new TextStyle(
          color: Colors.orange,
        ),
        padding: EdgeInsets.only(left: 15.0),
        onPressed: () => _onTapLogin(),
        child: new Text(
          "Inicia sesión o Crea una cuenta",
          style: new TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      );
    }
  }

  Padding createHeaderWithPadding(Widget child) {
    return new Padding(
      child: child,
      padding: EdgeInsets.symmetric(vertical: 6.0),
    );
  }
}
