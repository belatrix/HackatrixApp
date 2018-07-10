import 'package:flutter/material.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/event/event_page.dart';
import 'package:hackatrix/presentation/home/home_presenter.dart';
import 'package:hackatrix/presentation/util/theme.dart';

class DrawerItem {
  String title;
  var icon;
  bool isDivider;

  DrawerItem(this.title, this.icon, this.isDivider);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem('Eventos', Icon(Icons.today), false),
    new DrawerItem('Mis Datos & Ideas', null, false),
    new DrawerItem('Mi Cuenta', Icon(Icons.person), false),
    new DrawerItem(
        'Mis Ideas', ImageIcon(AssetImage('images/ic_idea.png')), false),
    new DrawerItem('Organizador', null, false),
    new DrawerItem('Registrar Asistencia', Icon(Icons.edit), false),
    new DrawerItem('Buscar Participantes', Icon(Icons.search), false),
    new DrawerItem('Resumen Calificaciones', Icon(Icons.dashboard), false),
    new DrawerItem(null, null, true),
    new DrawerItem('Configuración', Icon(Icons.settings), false),
    new DrawerItem('Sobre la aplicación', Icon(Icons.info), false),
    new DrawerItem('Ayuda', Icon(Icons.help), false),
  ];

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeView {
  HomePresenter _presenter;
  User _user;
  int _selectedDrawerIndex;

  _HomePageState() {
    _presenter = new HomePresenter(this);
    _user = null;
    _selectedDrawerIndex = 0;
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new EventPage();
      default:
    }
  }

  _onSelectedItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
    Navigator.of(context).pop();
  }

  Widget buildUserHeader() {
    return _user != null ? buildUserLogged() : buildEmptyUser();
  }

  Widget buildEmptyUser() {
    return new UserAccountsDrawerHeader(
        accountName: new Text(""),
        accountEmail: new RawMaterialButton(
          textStyle: new TextStyle(
            color: Colors.orange,
          ),
          child: new Text(
            "Inicia sesión o Crea una cuenta",
            style: new TextStyle(color: Colors.white),
          ),
          onPressed: () {
            print("iniciar sesión");
          },
        ));
  }

  Widget buildUserLogged() {
    return new UserAccountsDrawerHeader(
      accountName: new Text(_user.fullName,
          style: new TextStyle(
            color: Colors.white,
          )),
      accountEmail: new Text(_user.email,
          style: new TextStyle(
            color: Colors.white,
          )),
    );
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
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      var view;
      if (d.icon != null) {
        view = new ListTile(
          leading: d.icon,
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectedItem(i),
        );
      } else if (d.isDivider) {
        view = new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: new Divider(
                height: 1.0,
              ),
            ),
          ],
        );
      } else {
        view = new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: new Divider(
                height: 1.0,
              ),
            ),
            new Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: new Text(
                d.title,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        );
      }
      drawerOptions.add(view);
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.drawerItems[_selectedDrawerIndex].title,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: companyThemeIcon,
        elevation: 0.0,
      ),
      drawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Container(
                  color: CompanyColors.orange,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildUserHeader(),
                    ],
                  ),
                ),
                new Column(
                  children: drawerOptions,
                ),
              ],
            ),
          ],
        ),
      ),
      body: _getDrawerItemWidget(
        _selectedDrawerIndex,
      ),
    );
  }
}
