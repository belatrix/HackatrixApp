import 'package:hackatrix/data/repository/user_repository.dart';

abstract class CreateAccountView {
  void onResult();

  void onError(String message);
}

class CreateAccountPresenter {
  CreateAccountView _view;
  UserRepository _repository;

  CreateAccountPresenter(this._view, this._repository);

  void createAccount(String email) {
    _repository.create(email).then((user) => _view.onResult).catchError((onError) {
      print(onError.toString());
      _view.onError(onError.toString());
    });
  }
}
