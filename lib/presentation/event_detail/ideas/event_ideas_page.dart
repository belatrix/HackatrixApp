import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackatrix/data/repository/rest/event_rest.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/domain/model/idea.dart';
import 'package:hackatrix/presentation/event_detail/ideas/event_ideas_presenter.dart';

class EventIdeasPage extends StatefulWidget {
  final Event _event;

  EventIdeasPage(this._event);

  @override
  _EventIdeasPageState createState() => new _EventIdeasPageState();
}

class _EventIdeasPageState extends State<EventIdeasPage>
    with AutomaticKeepAliveClientMixin<EventIdeasPage>
    implements EventIdeasView {
  EventIdeasPresenter _presenter;
  List<Idea> _elements = List();
  Completer<Null> _completer;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  _EventIdeasPageState() {
    _presenter = new EventIdeasPresenter(this, new EventRest());
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
    _presenter.actionGetIdeasByEventList(widget._event.id);
    _refreshIndicatorKey.currentState.show();
    return _completer.future;
  }

  @override
  void onResult(List<Idea> list) {
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
              new IdeaItem(_elements[index]),
          itemCount: _elements.length),
      onRefresh: _refreshList,
    );
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

class IdeaItem extends StatelessWidget {
  final Idea _idea;

  IdeaItem(this._idea);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: ListTile(
        isThreeLine: true,
        key: new Key(_idea.id.toString()),
        title: new Text(_idea.title),
        subtitle: new Text(
          _idea.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      decoration: new BoxDecoration(
          border: new Border(bottom: new BorderSide(color: Colors.grey[300]))),
    );
  }
}
