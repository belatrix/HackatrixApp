import 'package:hackatrix/data/repository/event_repository.dart';
import 'package:hackatrix/domain/model/idea.dart';

abstract class EventIdeasView {
  void onResult(List<Idea> list);
}

class EventIdeasPresenter {
  EventIdeasView _view;
  EventRepository _repository;

  EventIdeasPresenter(this._view, this._repository);

  void actionGetIdeasByEventList(int eventId) {
    _repository
        .getIdeasByEventList(eventId)
        .then((items) => _view.onResult(items))
        .catchError((onError) {
      print(onError);
      // _view.onLoadContactsError();
      print("Error : $onError");
    });
  }
}
