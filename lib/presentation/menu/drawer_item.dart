import 'package:flutter/material.dart';

abstract class DrawerItem {
  String _drawerTitle;
  bool _forUserLogged;
  bool _jury;
  bool _moderator;
  bool _staff;

  DrawerItem(this._drawerTitle, this._forUserLogged, this._jury, this._moderator, this._staff);

  String get drawerTitle => _drawerTitle;

  bool get forUserLogged => _forUserLogged;

  bool get jury => _jury;

  bool get moderator => _moderator;

  bool get staff => _staff;
}

class ListItem extends DrawerItem {
  bool _showTitle;
  var _icon;

  ListItem(drawerTitle, this._showTitle, this._icon, forUserLogged, jury, moderator, staff)
      : super(drawerTitle, forUserLogged, jury, moderator, staff);

  bool get showTitle => _showTitle;

  get icon => _icon;
}

class DividerItem extends DrawerItem {
  DividerItem(forUserLogged, jury, moderator, staff) : super("", forUserLogged, jury, moderator, staff);
}

class HeadingItem extends DrawerItem {
  HeadingItem(drawerTitle, forUserLogged, jury, moderator, staff)
      : super(drawerTitle, forUserLogged, jury, moderator, staff);
}

final drawerItems = [
  new ListItem('Eventos', true, Icon(Icons.today), false, true, true, true),
  new HeadingItem('Mis Datos & Ideas', true, true, true, true),
  new ListItem('Mi Cuenta', false, Icon(Icons.person), true, true, true, true),
  new ListItem('Mis Ideas', true, ImageIcon(AssetImage('images/ic_idea.png')), true, true, true, true),
  new HeadingItem('Organizador', true, false, false, true),
  new ListItem('Registrar Asistencia', true, Icon(Icons.edit), true, false, false, true),
  new ListItem('Buscar Participantes', true, Icon(Icons.search), true, false, false, true),
  new ListItem('Resumen Calificaciones', true, Icon(Icons.dashboard), true, false, false, true),
  new HeadingItem('Moderador', true, false, true, false),
  new ListItem('Administrar Ideas', true, ImageIcon(AssetImage('images/ic_idea.png')), true, false, true, false),
  new HeadingItem("Jurado", true, true, false, false),
  new ListItem('Calificar Idea', true, Icon(Icons.edit), true, true, false, false),
  new DividerItem(false, true, true, true),
  new ListItem('Configuración', true, Icon(Icons.settings), false, true, true, true),
  new ListItem('Sobre la aplicación', true, Icon(Icons.info), false, true, true, true),
  new ListItem('Ayuda', true, Icon(Icons.help), false, true, true, true),
];
