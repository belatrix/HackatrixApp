import 'package:hackatrix/data/repository/event_repository.dart';
import 'package:hackatrix/domain/model/vote.dart';

abstract class EventVotesView {
  void onResult(List<Vote> list);
}

class EventVotesPresenter {
  EventVotesView _view;
  EventRepository _repository;

  EventVotesPresenter(this._view, this._repository);

  void actionGetVotesByEventList(int eventId) {
    _repository
        .getVotesByEventList(eventId)
        .then((items) => _view.onResult(items))
        .catchError((onError) {
      print(onError);
      // _view.onLoadContactsError();
      print("Error : $onError");
    });
  }
}
