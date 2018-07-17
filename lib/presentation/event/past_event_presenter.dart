import 'package:hackatrix/data/repository/event_repository.dart';

abstract class PastEventView{
  void onLoading();

  void onEmptyResult();

  void onResult(List<dynamic> list);

  void onError();
}

class PastEventPresenter{
  PastEventView _view;
  EventRepository _repository;

  PastEventPresenter(this._view, this._repository);

  void getPastEventList(int city){
    _view.onLoading();
    _repository.getPastEventList(city).then((items){
      if(items.length > 0){
        _view.onResult(items);
      }else{
        _view.onEmptyResult();
      }
    }).catchError((onError){
      print("Error : $onError");
      _view.onError();
    });
  }
}