import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackatrix/data/repository/rest/event_rest.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/presentation/event_detail/event_detail_page.dart';
import 'package:hackatrix/presentation/home/home_item.dart';
import 'package:hackatrix/presentation/home/home_presenter.dart';
import 'package:hackatrix/presentation/menu/menu_page.dart';
import 'package:hackatrix/presentation/util/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hackatrix/presentation/util/custom_widgets/my_scaffold.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeView {
  HomePresenter _presenter;
  List<Event> _elements = List();
  Completer<Null> _completer;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();

  _HomePageState() {
    _presenter = new HomePresenter(this, new EventRest());
  }

  @override
  void initState(){
    super.initState();
    _firstLoad();
  }

  _firstLoad() async{
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

  void _onTapEvent(Event event, BuildContext context) {
    print("event tapped: ${event.title}");
    Navigator.push(context, new MaterialPageRoute(
      builder: (BuildContext context) => new EventDetailPage(event),
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return new MyScaffold(
      key: _scaffoldKey,
      title: APP_NAME,
      drawer: new Drawer(
        child: new MenuSidePage(_scaffoldKey),
      ),
      body: buildStaggeredGridView(),
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
          new HomeItem(_elements[index], context, callBack: _onTapEvent)
      ),
      onRefresh: _refreshList,
    );
  }


}

