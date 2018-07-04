import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackatrix/data/repository/rest/event_rest.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/domain/model/vote.dart';
import 'package:hackatrix/presentation/event_detail/votes/event_votes_presenter.dart';

class EventVotesPage extends StatefulWidget {
  final Event _event;

  EventVotesPage(this._event);

  @override
  _EventVotesPageState createState() => new _EventVotesPageState();
}

class _EventVotesPageState extends State<EventVotesPage>
    with AutomaticKeepAliveClientMixin<EventVotesPage>
    implements EventVotesView {
  EventVotesPresenter _presenter;
  List<Vote> _elements = List();
  Completer<Null> _completer;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  _EventVotesPageState() {
    _presenter = new EventVotesPresenter(this, new EventRest());
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  _firstLoad() async {
    _refreshIndicatorKey.currentState.show();
  }

  Future<Null> _refreshList() {
    _completer = new Completer<Null>();
    _presenter.actionGetVotesByEventList(widget._event.id);
    _refreshIndicatorKey.currentState.show();
    return _completer.future;
  }

  @override
  void onResult(List<Vote> list) {
    _completer.complete();
    if (this.mounted) {
      setState(() {
        _elements = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildListView();
  }

  RefreshIndicator buildListView() {
    return new RefreshIndicator(
      key: _refreshIndicatorKey,
      child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              new VoteItem(_elements[index]),
          itemCount: _elements.length),
      onRefresh: _refreshList,
    );
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

class VoteItem extends StatelessWidget {
  final Vote _vote;

  VoteItem(this._vote);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: ListTile(
        key: new Key(_vote.id.toString()),
        title: new Text(_vote.title),
        subtitle: new Text(
          _vote.votes.toString(),
        ),
      ),
      decoration: new BoxDecoration(
          border: new Border(bottom: new BorderSide(color: Colors.grey[300]))),
    );
  }
}
