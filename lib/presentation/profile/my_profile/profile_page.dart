//import 'package:flutter/material.dart';
//import 'package:hackatrix/data/repository/rest/user_rest.dart';
//import 'package:hackatrix/domain/model/user.dart';
//import 'package:hackatrix/presentation/profile/my_profile/profile_presenter.dart';
//import 'package:hackatrix/presentation/util/custom_widgets/my_scaffold.dart';
//import 'package:hackatrix/presentation/util/custom_widgets/my_secondary_button.dart';
//import 'package:progress_hud/progress_hud.dart';
//import 'package:qr/qr.dart';
//import 'package:qr_flutter/qr_flutter.dart';
//
//class ProfilePage extends StatefulWidget {
//  final User _user;
//  final VoidCallback onLogOut;
//
//  ProfilePage(this._user, this.onLogOut);
//
//  @override
//  _ProfilePageState createState() => new _ProfilePageState();
//}
//
//class _ProfilePageState extends State<ProfilePage> implements ProfileView{
//  ProgressHUD _progressHUD;
//  ProfilePresenter _presenter;
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//  _ProfilePageState(){
//    _presenter = new ProfilePresenter(this, new UserRest());
//  }
//
//  @override
//  void onError(String message) {
//    _progressHUD.state.dismiss();
//    final snackBar = new SnackBar(content: new Text(message));
//    _scaffoldKey.currentState.showSnackBar(snackBar);
//  }
//
//  @override
//  void onResult() {
//    widget.onLogOut();
//    _progressHUD.state.dismiss();
//    Navigator.of(context).pop();
//  }
//
//  void _submit() {
//    _progressHUD.state.show();
//    _presenter.actionLogout();
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _progressHUD = new ProgressHUD(
//      backgroundColor: Colors.black12,
//      loading: false,
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new MyScaffold(
//      key: _scaffoldKey,
//      title: "Perfil",
//      body: new Stack(children: <Widget>[
//        new Container(
//            alignment: Alignment.center,
//            padding: new EdgeInsets.all(25.0),
//            child: new Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//                new Center( child: new QrImage(
//                  data: widget._user.email,
//                  errorCorrectionLevel: QrErrorCorrectLevel.M,
//                  size: 100.0,
//                )),
//                new Padding(
//                  padding: EdgeInsets.only(top: 20.0),
//                ),
//                new Center(
//                    child: new Text(
//                  widget._user.email,
//                  textAlign: TextAlign.center,
//                )),
//                new Center(
//                    child: new Text(
//                  widget._user.fullName,
//                  style: new TextStyle(fontSize: 20.0),
//                )),
//                new Center(
//                    child: new Text(
//                  widget._user.phoneNumber,
//                )),
//                new Center(
//                    child: new Text(
//                  widget._user.role?.name,
//                )),
//                new Padding(
//                  padding: EdgeInsets.only(top: 20.0),
//                ),
//                new MySecondaryButton(
//                  text: "Cerrar Sesión",
//                  onPressed: () => _submit(),
//                ),
//              ],
//            )),
//        _progressHUD,
//      ]),
//    );
//  }
//}
