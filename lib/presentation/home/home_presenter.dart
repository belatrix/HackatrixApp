import 'package:hackatrix/data/repository/event_repository.dart';
import 'package:hackatrix/domain/model/event.dart';

abstract class HomeView {
  void onResult(List<Event> list);
}

class HomePresenter {
  HomeView _view;
  EventRepository _repository;

  HomePresenter(this._view, this._repository);

  void actionGetEventList(int city) {
    print("cargando...");
    _repository
        .getEventList(city)
        .then((items) => _view.onResult(items))
        .catchError((onError) {
      print(onError);
      // _view.onLoadContactsError();
      print("Error : $onError");
    });
  }
}
