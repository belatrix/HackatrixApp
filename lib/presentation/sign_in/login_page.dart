import 'package:flutter/material.dart';
import 'package:hackatrix/data/repository/rest/user_rest.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_password_form_field.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_primary_button.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_secondary_button.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_text_form_field.dart';
import 'package:hackatrix/presentation/util/theme.dart';
import 'package:validator/validator.dart';

import 'change_password_page.dart';
import 'create_account_page.dart';
import 'forgot_password_page.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginView {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  LoginPresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPresenter(this, new UserRest());
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _presenter.actionAuthenticate(_email, _password);
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  @override
  void showPasswordResetScreen() async {
    User user = await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
      return new ChangePasswordPage();
    }));
    if (user != null) {
      Navigator.of(context).pop(user);
    }
  }

  @override
  void onResult(User user) {
    Navigator.of(context).pop(user);
  }

  @override
  void onError(String message) {
    final snackBar = new SnackBar(content: new Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _createAccount() async {
    bool accountCreated = await Navigator
        .of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) => new CreateAccountPage()));
    if (accountCreated) {
      final snackBar = new SnackBar(content: new Text("Te enviamos un correo con tu clave temporal."));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  void _forgotPassword() async {
    bool sentRequest = await Navigator
        .of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) => new ForgotPasswordPage()));
    if (sentRequest) {
      final snackBar = new SnackBar(content: new Text("Te enviamos un correo con tu clave temporal."));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: CompanyColors.orange,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        color: CompanyColors.orange,
        child: new Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.0))),
            margin: const EdgeInsets.only(left: 32.0, bottom: 32.0, right: 32.0, top: 48.0),
            child: Container(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    SizedBox(
                      height: 62.0,
                    ),
                    CustomTextFormField(
                      maxLines: 1,
                      labelText: "Correo electrónico",
                      textInputType: TextInputType.emailAddress,
                      validator: (val) => !isEmail(val) ? 'No es un email válido.' : null,
                      onSaved: (val) => _email = val,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    CustomPasswordFormField(
                      labelText: "Contraseña",
                      validator: (val) => val.isEmpty ? 'Contraseña no válida.' : null,
                      onSaved: (val) => _password = val,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: _forgotPassword,
                        child: Text(
                          "¿Olvidaste tu contraseña?",
                          style: Theme.of(context).textTheme.caption.apply(
                                color: CompanyColors.blue,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 42.0,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomSecondaryButton(
                          text: 'Iniciar sesión',
                          onPressed: _submit,
                        )),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomPrimaryButton(
                        text: 'Crear cuenta',
                        onPressed: _createAccount,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'images/ic_login_logo.png',
            ),
          ),
        ]),
      ),
    );
  }
}
