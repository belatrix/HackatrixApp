import 'package:hackatrix/data/repository/event_repository.dart';
import 'package:hackatrix/domain/model/meeting.dart';

abstract class MeetingListView {
  void onResult(List<Meeting> list);
}

class MeetingListPresenter {
  MeetingListView _view;
  EventRepository _repository;

  MeetingListPresenter(this._view, this._repository);

  void actionGetMeetingList(int eventId) {
    _repository
        .getMeetingByEventList(eventId)
        .then((items) => _view.onResult(items))
        .catchError((onError) {
      print(onError);
      // _view.onLoadContactsError();
      print("Error : $onError");
    });
  }
}
