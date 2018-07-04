import 'package:flutter/material.dart';
import 'package:hackatrix/data/repository/rest/user_rest.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/profile/forgot_password/forgot_password_page.dart';
import 'package:hackatrix/presentation/profile/login/login_presenter.dart';
import 'package:hackatrix/presentation/util/custom_widgets/my_primary_button.dart';
import 'package:hackatrix/presentation/util/custom_widgets/my_scaffold.dart';
import 'package:hackatrix/presentation/util/custom_widgets/my_secondary_button.dart';
import 'package:hackatrix/presentation/util/custom_widgets/password_field.dart';
import 'package:progress_hud/progress_hud.dart';

class LoginPage extends StatefulWidget {

  final VoidCallback onLogin;

  LoginPage(this.onLogin);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginView {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  LoginPresenter _presenter;
  ProgressHUD _progressHUD;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _LoginPageState() {
    _presenter = new LoginPresenter(this, new UserRest());
  }

  @override
  void initState(){
    super.initState();
      _progressHUD = new ProgressHUD(
        backgroundColor: Colors.black12,
        loading: false,
      );
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _progressHUD.state.show();
      _presenter.actionAuthenticate(_email, _password);
      //dismiss the keyboard
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  @override
  void onResult(User user){
    widget.onLogin();
    _progressHUD.state.dismiss();
    Navigator.of(context).pop();
  }

  @override
  void onError(String message) {
    _progressHUD.state.dismiss();
    final snackBar = new SnackBar(content: new Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _forgotPassword() {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new ForgotPasswordPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MyScaffold(
      key: _scaffoldKey,
      title: "Iniciar Sesión",
      body: new Stack(children: <Widget>[ 
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 20.0),
          child: new Form(
            key: this._formKey,
            autovalidate: true,
            child: new ListView(
              children: <Widget>[
                _getVerticalPadding(),
                new Image.asset(
                  "images/ic_launcher.png",
                  height: 100.0,
                  fit: BoxFit.contain,
                ),
                _getVerticalPadding(),
                new TextFormField(
                  autocorrect: false,
                  autovalidate: false,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  decoration: new InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Email",
                  ),
                  validator: (val) =>
                      !val.contains('@') ? 'No es un email válido.' : null,
                  onSaved: (val) => _email = val,
                ),
                _getVerticalPadding(),
                new PasswordField(
                  labelText: 'Contraseña',
                  inputBorder: const OutlineInputBorder(),
                  validator: (val) =>
                      val.isEmpty ? 'Contraseña no válida.' : null,
                  onSaved: (val) => _password = val,
                ),
                _getVerticalPadding(),
                new RawMaterialButton(
                  child: new Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Olvidé mi contraseña",
                      textAlign: TextAlign.end,
                    ),
                  ),
                  textStyle: new TextStyle(
                    color: Colors.orange,
                  ),
                  onPressed: _forgotPassword,
                ),
                _getVerticalPadding(),
                new MyPrimaryButton(
                  onPressed: _submit,
                  text: 'Login',
                ),
                _getVerticalPadding(),
                new MySecondaryButton(
                  onPressed: _submit,
                  text: 'Crear Cuenta',
                ),
              ],
            ),
          ))
          ,
        _progressHUD,
          ]),
    );
  }

  Padding _getVerticalPadding() {
    return new Padding(padding: EdgeInsets.symmetric(vertical: 10.0));
  }
}
