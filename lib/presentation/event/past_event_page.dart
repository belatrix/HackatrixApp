import 'package:flutter/material.dart';
import 'package:hackatrix/data/repository/rest/event_rest.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/domain/model/status.dart';
import 'package:hackatrix/presentation/event/past_event_presenter.dart';
import 'package:hackatrix/presentation/event_detail/event_detail_page.dart';
import 'package:hackatrix/presentation/util/theme.dart';

import 'event_item.dart';

class PastEventPage extends StatefulWidget {
  final int _cityId;

  PastEventPage(this._cityId);

  @override
  _PastEventPageState createState() => _PastEventPageState();
}

class _PastEventPageState extends State<PastEventPage> implements PastEventView {
  PastEventPresenter _presenter;
  List<dynamic> _elements = List();
  Status _status;

  _PastEventPageState() {
    _presenter = new PastEventPresenter(this, new EventRest());
  }

  @override
  void initState() {
    _loadEvents();
    super.initState();
  }

  void _loadEvents() async {
    _presenter.getPastEventList(widget._cityId);
  }

  void _onTapEvent(Event event) {
    Navigator.of(context).push(
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
  void onEmptyResult() {
    _status = Status.EMPTY;
    _elements.clear();
    setState(() {});
  }

  @override
  void onResult(List<dynamic> list) {
    _status = Status.SUCCESS;
    _elements = list;
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
    return new Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text("Eventos Pasados"),
        ),
        body: Container(
          color: CompanyColors.offwhite,
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
        ));
  }

  Widget buildOnEmpty(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text("Eventos Pasados"),
        ),
        body: Container(
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
                  _loadEvents();
                }),
                child: new Text(
                  "Inténtelo nuevamente",
                  style: Theme.of(context).textTheme.caption.apply(
                        color: CompanyColors.blue[900],
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildOnSuccess(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text("Eventos Pasados"),
        ),
        body: Container(
            color: CompanyColors.offwhite,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.57,
              padding: EdgeInsets.all(8.0),
              children: List.generate(_elements.length, (index) {
                return new HomeItem(_elements[index], callback: _onTapEvent);
              }),
            )));
  }
}
