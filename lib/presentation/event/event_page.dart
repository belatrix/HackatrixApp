import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hackatrix/data/repository/rest/event_rest.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/presentation/event/event_item.dart';
import 'package:hackatrix/presentation/event/evento_presenter.dart';
import 'package:hackatrix/presentation/event_detail/event_detail_page.dart';
import 'package:hackatrix/presentation/util/theme.dart';

class EventPage extends StatefulWidget {
  final int _cityId;

  EventPage(this._cityId);

  @override
  _EventPageState createState() {
    return new _EventPageState();
  }
}

class _EventPageState extends State<EventPage> implements EventView {
  EventPresenter _presenter;
  List<dynamic> _elements = List();

  _EventPageState() {
    _presenter = new EventPresenter(this, new EventRest());
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  _firstLoad() async {
    _presenter.actionGetEventList(widget._cityId);
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
  void onResult(List<dynamic> list) {
    for (int i = 0; i < list.length; i++) {
      if (!list[i].isUpcoming) {
        list[i].title = list[i].title.replaceAll("Hackatrix ", "");
      }
    }
    _elements..add("");
    setState(() {
      _elements = list;
    });
  }

  Widget buildPastEventsView(BuildContext context) {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new GestureDetector(
          onTap: () => print('Open past events'),
          child: new Text(
            "Ver eventos pasados",
            style: Theme.of(context).textTheme.caption.apply(
                  color: CompanyColors.blue[900],
                ),
            textAlign: TextAlign.center,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CompanyColors.offwhite,
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            padding: EdgeInsets.all(8.0),
            itemCount: _elements.length,
            staggeredTileBuilder: (int index) {
              if (_elements != null && _elements.length > 0 && index != _elements.length - 1) {
                return new StaggeredTile.count(_elements[index].isUpcoming ? 2 : 1, 1.75);
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
}
