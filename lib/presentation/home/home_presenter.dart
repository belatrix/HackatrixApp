import 'package:hackatrix/presentation/util/preferences/preference_manager.dart';

abstract class HomeView {
  void onUserLoaded(user);
}

class HomePresenter {
  HomeView _view;
  PreferenceManager _preferences;

  HomePresenter(this._view) {
    _preferences = new PreferenceManager();
  }

  loadUser() {
    _preferences.getUser().then((user) {
      _view.onUserLoaded(user);
    });
  }
}
