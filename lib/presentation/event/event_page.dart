import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hackatrix/data/repository/rest/event_rest.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/presentation/event/event_item.dart';
import 'package:hackatrix/presentation/event/evento_presenter.dart';
import 'package:hackatrix/presentation/event_detail/event_detail_page.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => new _EventPageState();
}

class _EventPageState extends State<EventPage> implements EventView {
  EventPresenter _presenter;
  List<Event> _elements = List();
  Completer<Null> _completer;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  _EventPageState() {
    _presenter = new EventPresenter(this, new EventRest());
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
    _presenter.actionGetEventList(1);
    return _completer.future;
  }

  @override
  void onResult(List<Event> list) {
    _completer.complete();
    setState(() {
      _elements = list;
    });
  }

  void _onTapEvent(Event event) {
    print("event tapped: ${event.title}");
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new EventDetailPage(event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: buildStaggeredGridView(),
    );
  }

  RefreshIndicator buildStaggeredGridView() {
    return new RefreshIndicator(
      key: _refreshIndicatorKey,
      child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          padding: EdgeInsets.all(4.0),
          itemCount: _elements.length,
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(index == 0 ? 2 : 1, 1.2),
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          itemBuilder: (BuildContext context, int index) =>
              new HomeItem(_elements[index], callBack: _onTapEvent)),
      onRefresh: _refreshList,
    );
  }
}
