import 'package:hackatrix/data/repository/event_repository.dart';
import 'package:hackatrix/domain/model/event.dart';

abstract class EventView {
  void onResult(List<Event> list);
}

class EventPresenter {
  EventView _view;
  EventRepository _repository;

  EventPresenter(this._view, this._repository);

  void actionGetEventList(int city) {
    print("cargando...");
    _repository.getUpcomingEventList(city).then((items) => _view.onResult(items)).catchError((onError) {
      print("Error : $onError");
    });
  }
}
