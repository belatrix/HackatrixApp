import 'package:hackatrix/data/repository/event_repository.dart';

abstract class ScanQRView {
  void onResult(String email);
  void onError(String errorMessage);
}

class ScanQRPresenter {
  ScanQRView _view;
  EventRepository _repository;

  ScanQRPresenter(this._view, this._repository);

  void actionRegisterAttendance(int meetingId, String email) {
    _repository
        .registerAttendance(meetingId, email)
        .then((result) => _view.onResult(email))
        .catchError((onError) {
      print(onError);
      _view.onError(onError.toString());
    });
  }
}
