import 'package:hackatrix/data/repository/user_repository.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/util/preferences/preference_manager.dart';

abstract class ChangePasswordView {
  void onResult(User user);

  void onError(String message);
}

class ChangePasswordPresenter {
  ChangePasswordView _view;
  UserRepository _repository;
  PreferenceManager _preferences = new PreferenceManager();

  ChangePasswordPresenter(this._view, this._repository);

  void changePassword(String oldPassword, String newPassword) {
    _repository.userUpdatePassword(oldPassword, newPassword).then((user) {
      _view.onResult(user);
      _preferences.saveUser(user);
    }).catchError((onError) {
      print(onError.toString());
      _view.onError(onError.toString());
    });
  }
}
