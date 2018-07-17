import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hackatrix/data/repository/rest/event_rest.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/domain/model/status.dart';
import 'package:hackatrix/presentation/event_detail/event_detail_page.dart';
import 'package:hackatrix/presentation/util/theme.dart';

import 'event_item.dart';
import 'event_presenter.dart';
import 'past_event_page.dart';

class EventPage extends StatefulWidget {
  final Key key;
  final int cityId;

  EventPage({this.key, this.cityId}) : super(key: key);

  @override
  EventPageState createState() {
    return new EventPageState(cityId);
  }
}

class EventPageState extends State<EventPage> implements EventView {
  EventPresenter _presenter;
  List<dynamic> _elements = List();
  Status _status;
  int _cityId = 0;

  EventPageState(this._cityId) {
    _presenter = new EventPresenter(this, new EventRest());
  }

  @override
  void initState() {
    loadNewEvents(_cityId);
    super.initState();
  }

  void loadNewEvents(cityId) async {
    this._cityId = cityId;
    _presenter.actionGetEventList(_cityId);
  }

  void _onTapEvent(Event event) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new EventDetailPage(event),
      ),
    );
  }

  @override
  void onLoading() {
    _status = Status.LOADING;
    setState(() {});
  }

  @override
  void onResult(List<dynamic> list) {
    _status = Status.SUCCESS;
    for (int i = 0; i < list.length; i++) {
      if (!list[i].isGoing) {
        list[i].title = list[i].title.replaceAll("Hackatrix ", "");
      }
    }
    _elements = list;
    _elements.add("");
    setState(() {});
  }

  @override
  void onEmptyResult() {
    _status = Status.EMPTY;
    _elements.clear();
    setState(() {});
  }

  @override
  void onError() {
    _status = Status.ERROR;
    _elements.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }

  Widget buildContent(BuildContext context) {
    switch (_status) {
      case Status.SUCCESS:
        return buildOnSuccess(context);
      case Status.LOADING:
        return buildOnLoading(context);
      default:
        return buildOnEmpty(context);
    }
  }

  Widget buildOnLoading(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40.0,
          ),
          Text(
            "Cargando próximos eventos",
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildOnEmpty(BuildContext context) {
    return Container(
      color: CompanyColors.offwhite,
      padding: EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Image.asset(
            'images/ic_empty_events.png',
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 16.0,
          ),
          new Text(
            "No se encontró ningún próximo evento.",
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
          new GestureDetector(
            onTap: (() {
              loadNewEvents(_cityId);
            }),
            child: new Text(
              "Inténtelo nuevamente",
              style: Theme.of(context).textTheme.caption.apply(
                    color: CompanyColors.blue[900],
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 32.0,
          ),
          buildPastEventsView(context),
        ],
      ),
    );
  }

  Widget buildOnSuccess(BuildContext context) {
    return Container(
        color: CompanyColors.offwhite,
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            padding: EdgeInsets.all(8.0),
            itemCount: _elements.length,
            staggeredTileBuilder: (int index) {
              if (_elements != null && _elements.length > 0 && index != _elements.length - 1) {
                return new StaggeredTile.count(_elements[index].isGoing ? 2 : 1, 1.75);
              } else if (index == _elements.length - 1) {
                return new StaggeredTile.count(2, 0.25);
              } else {
                return new StaggeredTile.count(2, 1);
              }
            },
            itemBuilder: (BuildContext context, int index) {
              if (index < _elements.length - 1) {
                return new HomeItem(_elements[index], callback: _onTapEvent);
              } else {
                return buildPastEventsView(context);
              }
            }));
  }

  Widget buildPastEventsView(BuildContext context) {
    return new Container(
        color: CompanyColors.offwhite,
        padding: EdgeInsets.all(16.0),
        child: new GestureDetector(
          onTap: () => Navigator
              .of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) => PastEventPage(_cityId))),
          child: new Text(
            "Ver eventos pasados",
            style: Theme.of(context).textTheme.caption.apply(
                  color: CompanyColors.blue[900],
                ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
