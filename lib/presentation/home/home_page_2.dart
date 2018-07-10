import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/presentation/event_detail/event_detail_page.dart';
import 'package:hackatrix/presentation/home/home_bloc.dart';
import 'package:hackatrix/presentation/home/home_item.dart';
import 'package:hackatrix/presentation/home/home_provider.dart';
import 'package:hackatrix/presentation/menu/menu_page.dart';
import 'package:hackatrix/presentation/util/constants.dart';
import 'package:hackatrix/presentation/util/custom_widgets/my_scaffold.dart';

class HomePage2 extends StatelessWidget {
  //Completer<Null> _completer;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<Null> _completer;

  // Events
  void _onTapEvent(Event event, BuildContext context) {
    print("event tapped: ${event.title}");
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new EventDetailPage(event),
      ),
    );
  }

  @override
  void onResult(List<Event> list) {
    _completer.complete();
  }

  // Views
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = HomeProvider.of(context);
    homeBloc.query.add(1);

    return new MyScaffold(
      key: _scaffoldKey,
      title: APP_NAME,
      drawer: new Drawer(
        child: new MenuSidePage(_scaffoldKey),
      ),
      body: buildStaggeredGridView(homeBloc),
    );
  }

  RefreshIndicator buildStaggeredGridView(HomeBloc homeBloc) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      child: StreamBuilder(
        stream: homeBloc.results,
        builder: (context, snapshot) => StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            padding: EdgeInsets.all(4.0),
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(index == 0 ? 2 : 1, 1.2),
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            itemBuilder: (BuildContext context, int index) => new HomeItem(
                snapshot.data[index], context,
                callBack: _onTapEvent)),
      ),
      onRefresh: () async {
        _completer = new Completer<Null>();
        homeBloc.query.add(1);
        homeBloc.results.listen((List<Event> list) {
          if (_completer != null) _completer.complete();
        });
        return _completer.future;
      },
    );
  }
}
