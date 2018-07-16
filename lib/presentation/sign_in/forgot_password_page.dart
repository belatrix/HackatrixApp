import 'package:flutter/material.dart';
import 'package:hackatrix/data/repository/rest/user_rest.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_secondary_button.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_text_form_field.dart';
import 'package:hackatrix/presentation/util/theme.dart';
import 'package:validator/validator.dart';

import 'forgot_password_presenter.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => new _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> implements RecoverView {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _email;
  RecoverPresenter _presenter;

  _ForgotPasswordPageState() {
    _presenter = new RecoverPresenter(this, new UserRest());
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _presenter.recoverPassword(_email);
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  @override
  void onResult() {
    Navigator.of(context).pop(true);
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
              Navigator.of(context).pop(false);
            }),
        title: Text('Recuperar Contraseña'),
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
                        "Ingresa tu correo electrónico para poder mandarte una nueva contraseña.",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: Theme.of(context).textTheme.subhead.apply(
                              color: Colors.black54,
                            ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      CustomTextFormField(
                        maxLines: 1,
                        labelText: "Correo electrónico",
                        textInputType: TextInputType.emailAddress,
                        validator: (val) => !isEmail(val) ? 'No es un email válido.' : null,
                        onSaved: (val) => _email = val,
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomSecondaryButton(
                            text: 'Recuperar Contraseña',
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
