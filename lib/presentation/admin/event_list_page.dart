import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackatrix/data/repository/rest/event_rest.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/presentation/admin/event_list_presenter.dart';
import 'package:hackatrix/presentation/admin/menu_admin/menu_admin_page.dart';
import 'package:hackatrix/presentation/util/custom_widgets/my_scaffold.dart';

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => new _EventListPageState();
}

class _EventListPageState extends State<EventListPage>
    with AutomaticKeepAliveClientMixin<EventListPage>
    implements EventListView {
  EventListPresenter _presenter;
  List<Event> _elements = List();
  Completer<Null> _completer;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  _EventListPageState() {
    _presenter = new EventListPresenter(this, new EventRest());
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
    _refreshIndicatorKey.currentState.show();
    return _completer.future;
  }

  @override
  void onResult(List<Event> list) {
    _completer.complete();
    if (this.mounted) {
      setState(() {
        _elements = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildUI();
  }

  MyScaffold buildUI() {
    return new MyScaffold(
        title: "Eventos",
        body: new RefreshIndicator(
          key: _refreshIndicatorKey,
          child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  new EventItem(_elements[index], context),
              itemCount: _elements.length),
          onRefresh: _refreshList,
        ));
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

class EventItem extends StatelessWidget {
  final Event _event;
  final BuildContext _context;

  EventItem(this._event, this._context);

  _onEventSelected() {
    Navigator.push(
      _context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new MenuAdminPage(_event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: ListTile(
          onTap: _onEventSelected,
          isThreeLine: true,
          key: new Key(_event.id.toString()),
          title: new Text(_event.title, style: TextStyle(fontWeight: FontWeight.w500),),
          subtitle: new Text(
            _event.address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        decoration:
            new BoxDecoration(border: new Border(bottom: new BorderSide(color: Colors.grey[300]))));
  }
}
