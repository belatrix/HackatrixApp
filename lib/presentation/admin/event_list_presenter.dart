import 'package:hackatrix/data/repository/event_repository.dart';
import 'package:hackatrix/domain/model/event.dart';

abstract class EventListView {
  void onResult(List<Event> list);
}

class EventListPresenter {
  EventListView _view;
  EventRepository _repository;

  EventListPresenter(this._view, this._repository);

  void actionGetEventList(int city) {
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
