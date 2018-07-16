import 'package:flutter/material.dart';
import 'package:hackatrix/data/repository/rest/user_rest.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_password_form_field.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_secondary_button.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_text_form_field.dart';
import 'package:hackatrix/presentation/util/theme.dart';

import 'change_password_presenter.dart';

class ChangePasswordPage extends StatefulWidget {

  ChangePasswordPage();

  @override
  _ChangePasswordPageState createState() => new _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> implements ChangePasswordView {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _oldPassword;
  String _newPassword;
  ChangePasswordPresenter _presenter;

  TextEditingController _newPasswordController = TextEditingController();

  _ChangePasswordPageState() {
    _presenter = new ChangePasswordPresenter(this, new UserRest());
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _presenter.changePassword(_oldPassword, _newPassword);
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  @override
  void onResult(User user) {
    Navigator.of(context).pop(user);
  }

  @override
  void onError(String message) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text('Cambiar Contraseña'),
      ),
      body: Container(
        color: CompanyColors.orange,
        child: new Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.0))),
              margin: const EdgeInsets.all(32.0),
              child: Container(
                padding: EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Antes de poder continuar, cambia tu contraseña temporal por una nueva contraseña.",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: Theme.of(context).textTheme.subhead.apply(
                              color: Colors.black54,
                            ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      CustomPasswordFormField(
                        labelText: "Antigua contraseña",
                        validator: (val) => val.isEmpty ? 'Contraseña no válida.' : null,
                        onSaved: (val) => _oldPassword = val,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      CustomTextFormField(
                        labelText: "Nueva contraseña",
                        controller: _newPasswordController,
                        obscureText: true,
                        validator: (val) => val.isEmpty ? 'Contraseña no válida.' : null,
                        onSaved: (val) => _newPassword = val,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      CustomTextFormField(
                        labelText: "Confirmar nueva contraseña",
                        obscureText: true,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Contraseña no válida.';
                          } else if (_newPasswordController.text != val) {
                            return 'Las contraseñas deben coincidir';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomSecondaryButton(
                            text: 'Cambiar contraseña',
                            onPressed: _submit,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
