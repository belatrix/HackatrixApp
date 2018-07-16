import 'package:hackatrix/data/repository/user_repository.dart';

abstract class RecoverView {
  void onResult();

  void onError(String message);
}

class RecoverPresenter {
  RecoverView _view;
  UserRepository _repository;

  RecoverPresenter(this._view, this._repository);

  void recoverPassword(String email) {
    _repository.recoverPassword(email).then((requestSent) => _view.onResult()).catchError((onError) {
      print(onError.toString());
      _view.onError(onError.toString());
    });
  }
}
