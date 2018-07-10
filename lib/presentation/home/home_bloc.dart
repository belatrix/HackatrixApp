import 'dart:async';
import 'package:hackatrix/data/repository/event_repository.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final EventRepository repository;

  Stream<List<Event>> _results = Stream.empty();

  ReplaySubject<int> _query = ReplaySubject<int>();

  // Getters
  Stream<List<Event>> get results => _results;

  Sink<int> get query => _query;

  HomeBloc(this.repository) {
    _results =
        // Use  distinct() when you want to listen for different events
        //_query.distinct().asyncMap(repository.getEventList).asBroadcastStream();
        _query.asyncMap(repository.getEventList).asBroadcastStream();
  }

  void dispose() {
    _query.close();
  }
}
