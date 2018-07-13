import 'package:flutter/widgets.dart';
import 'package:hackatrix/data/repository/rest/user_rest.dart';
import 'package:hackatrix/presentation/profile/login/bloc/authenticate/login_bloc.dart';

class LoginProvider extends InheritedWidget {
  final LoginBloC loginBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloC of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(LoginProvider) as LoginProvider)
          .loginBloc;

  LoginProvider({Key key, LoginBloC loginBloc, Widget child})
      : this.loginBloc = loginBloc ?? LoginBloC(UserRest()),
        super(child: child, key: key);
}
