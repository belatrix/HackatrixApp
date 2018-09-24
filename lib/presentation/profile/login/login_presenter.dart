import 'package:hackatrix/data/repository/user_repository.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/util/preferences/preference_manager.dart';

abstract class LoginView {
  void onResult(User user);
  void onError(String message);
}

class LoginPresenter {
  LoginView _view;
  UserRepository _repository;
  PreferenceManager _preferences = new PreferenceManager();

  LoginPresenter(this._view, this._repository);

  void actionAuthenticate(String email, String password) {
    /*_repository
        .authenticate(email, password)
        .then((token) => _getUserProfile(token))
        .catchError((onError) {
      print(onError.toString());
      _view.onError(onError.toString());
    });*/
  }

  _getUserProfile(String token) {
    _repository.profile(token).then((user) {
      _view.onResult(user);
      _preferences.saveUser(user);
      _preferences.saveToken(token);
    }).catchError((onError) {
      print(onError.toString());
      _view.onError(onError.toString());
    });
  }
}