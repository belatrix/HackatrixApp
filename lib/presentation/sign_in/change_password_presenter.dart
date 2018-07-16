import 'package:hackatrix/data/repository/user_repository.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/util/preferences/preference_manager.dart';

abstract class ChangePasswordView {
  void onResult();
  void onError(String message);
}

class ChangePasswordPresenter {
  ChangePasswordView _view;
  UserRepository _repository;

  ChangePasswordPresenter(this._view, this._repository);

  void changePassword(String oldPassword, String newPassword) {
//    _repository
//
//        .authenticate(email)
//        .then((token) => _getUserProfile(token))
//        .catchError((onError) {
//      print(onError.toString());
//      _view.onError(onError.toString());
//    });
  }
}