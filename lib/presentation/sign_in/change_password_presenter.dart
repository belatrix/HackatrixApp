import 'package:hackatrix/data/repository/user_repository.dart';
import 'package:hackatrix/domain/model/user.dart';

abstract class ChangePasswordView {
  void onResult(User user);

  void onError(String message);
}

class ChangePasswordPresenter {
  ChangePasswordView _view;
  UserRepository _repository;

  ChangePasswordPresenter(this._view, this._repository);

  void changePassword(String oldPassword, String newPassword) {
    _repository
        .userUpdatePassword(oldPassword, newPassword)
        .then((user) => _view.onResult(user))
        .catchError((onError) {
      print(onError.toString());
      _view.onError(onError.toString());
    });
  }
}
