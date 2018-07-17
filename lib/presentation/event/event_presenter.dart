import 'package:hackatrix/data/repository/event_repository.dart';

abstract class EventView {
  void onLoading();

  void onEmptyResult();

  void onResult(List<dynamic> list);

  void onError();
}

class EventPresenter {
  EventView _view;
  EventRepository _repository;

  EventPresenter(this._view, this._repository);

  void actionGetEventList(int city) {
    _view.onLoading();
    _repository.getUpcomingEventList(city).then((items) {
      if (items.length > 0) {
        _view.onResult(items);
      } else {
        _view.onEmptyResult();
      }
    }).catchError((onError) {
      print("Error : $onError");
      _view.onError();
    });
  }
}
