import 'package:hackatrix/data/repository/user_repository.dart';
import 'package:hackatrix/presentation/util/preferences/preference_manager.dart';

abstract class ProfileView {
  void onResult();
  void onError(String message);
}

class ProfilePresenter {
  ProfileView _view;
  UserRepository _repository;
  PreferenceManager _preferences = new PreferenceManager();

  ProfilePresenter(this._view, this._repository);

  void actionLogout() {
    _repository.logout().then((result) {
      _preferences.clearData();
      _view.onResult();
    }).catchError((onError) {
      print(onError.toString());
      _view.onError(onError.toString());
    });
  }
}
