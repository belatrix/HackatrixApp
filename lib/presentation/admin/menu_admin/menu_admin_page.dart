//import 'package:flutter/material.dart';
//import 'package:hackatrix/domain/model/event.dart';
//import 'package:hackatrix/domain/model/user.dart';
//import 'package:hackatrix/presentation/admin/register_assistance/meeting_list_page.dart';
//import 'package:hackatrix/presentation/util/custom_widgets/my_scaffold.dart';
//import 'package:hackatrix/presentation/util/preferences/preference_manager.dart';
//
//class MenuAdminPage extends StatefulWidget {
//  final Event _event;
//  MenuAdminPage(this._event);
//
//  @override
//  _MenuAdminPageState createState() => new _MenuAdminPageState();
//}
//
//class _MenuAdminPageState extends State<MenuAdminPage> {
//  User _user;
//  PreferenceManager _preferences = new PreferenceManager();
//
//  @override
//  void initState() {
//    super.initState();
//    _loadCurrentUser();
//  }
//
//  _loadCurrentUser() async {
//    _user = await _preferences.getUser();
//    setState(() {});
//  }
//
//  _onClickRegister() {
//    Navigator.push(
//      context,
//      new MaterialPageRoute(
//        builder: (BuildContext context) => new MeetingListPage(widget._event),
//      ),
//    );
//  }
//
//  _onClickManageIdeas() {
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    var list = new List<Widget>();
//    if (_user != null) {
//      if (_user.isModerator || _user.isStaff) {
//        list.add(buildChild(
//            "Registrar Asistencia",
//            "Permite registrar la asistencia por medio de la camara y códigos QR",
//            _onClickRegister));
//
//        list.add(buildChild(
//            "Gestionar Ideas",
//            "Permite gestionar las ideas registradas por los participantes",
//            _onClickManageIdeas));
//      }
//    }
//
//    return new MyScaffold(
//        title: widget._event.title,
//        body: new ListView(
//          children: list,
//        ));
//  }
//
//  Widget buildChild(String title, String description, VoidCallback callBack) {
//    return new Card(
//        elevation: 5.0,
//        margin: EdgeInsets.all(12.0),
//        child: new FlatButton(
//          onPressed: callBack,
//          child: new Padding(
//            padding: EdgeInsets.all(10.0),
//            child: new ListTile(
//              title: new Text(
//                title,
//                style: new TextStyle(
//                  fontSize: 16.0,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//              subtitle: new Text(description),
//              trailing: const Icon(Icons.keyboard_arrow_right),
//            ),
//          ),
//        ));
//  }
//}
