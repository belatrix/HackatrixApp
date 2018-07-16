import 'package:hackatrix/data/repository/user_repository.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/util/preferences/preference_manager.dart';

abstract class CreateAccountView {
  void onResult();
  void onError(String message);
}

class RecoverPresenter {
  CreateAccountView _view;
  UserRepository _repository;

  RecoverPresenter(this._view, this._repository);

  void createAccount(String email) {
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