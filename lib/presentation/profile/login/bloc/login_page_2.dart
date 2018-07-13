import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackatrix/presentation/profile/login/bloc/authenticate/login_bloc.dart';
import 'package:hackatrix/presentation/profile/login/bloc/authenticate/login_provider.dart';
import 'package:hackatrix/presentation/util/custom_widgets/my_primary_button.dart';
import 'package:hackatrix/presentation/util/custom_widgets/my_scaffold.dart';
import 'package:hackatrix/presentation/util/custom_widgets/my_secondary_button.dart';
import 'package:hackatrix/presentation/util/custom_widgets/password_field.dart';
import 'package:progress_hud/progress_hud.dart';

class LoginPage2 extends StatefulWidget {
  final VoidCallback onLogin;

  LoginPage2(this.onLogin);

  @override
  State<StatefulWidget> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  // keys
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      key: _scaffoldKey,
      title: "Iniciar Sesión",
      body: getBodyView(),
    );
  }

  Widget getBodyView() {
    final LoginBloC bloc = LoginProvider.of(context);

    return Stack(
      children: [
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 20.0),
          child: new Form(
            key: _formKey,
            autovalidate: true,
            child: new ListView(
              children: [
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
                      bloc.validateFieldForInput(LoginInput.username, val),
                  onSaved: (val) => _email = val,
                ),
                _getVerticalPadding(),
                new PasswordField(
                  labelText: 'Contraseña',
                  inputBorder: const OutlineInputBorder(),
                  validator: (val) =>
                      bloc.validateFieldForInput(LoginInput.password, val),
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
                  onPressed: () {
                    bloc.forgotPassword(context);
                  },
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
          ),
        ),
        StreamBuilder(
          stream: bloc.output,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.active) {
              //print("Stream event");
              switch (snapshot.data.loginOutCase) {
                case LoginOutCase.isLoading:
                  {
                    return snapshot.data.info
                        ? _getProgressHUD(true)
                        : _getEmptyContainer();
                  }
                case LoginOutCase.errorMessage:
                  {
                    Future
                        .delayed(Duration(milliseconds: 400))
                        .whenComplete(() {
                      _onError(snapshot.data.info);
                    });
                    return _getEmptyContainer();
                  }
                case LoginOutCase.token:
                  {
                    Future
                        .delayed(Duration(milliseconds: 400))
                        .whenComplete(() {
                      _onLoginDone();
                    });
                    return _getEmptyContainer();
                  }
              }
            } else {
              return _getEmptyContainer();
            }
          },
        ),
      ],
    );
  }

  void _submit() {
    final LoginBloC bloc = LoginProvider.of(context);
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      bloc.input.add(LoginCredentials(_email, _password));
      //dismiss the keyboard
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  _onLoginDone() {
    widget.onLogin();
    Navigator.of(context).pop();
  }

  _onError(String message) {
    final snackBar = SnackBar(content: new Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Padding _getVerticalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  Widget _getEmptyContainer() {
    return Container(
      height: 0.0,
      width: 0.0,
      color: Colors.transparent,
    );
  }

  ProgressHUD _getProgressHUD(bool loading) {
    return ProgressHUD(
      backgroundColor: Colors.black12,
      loading: loading,
    );
  }
}
