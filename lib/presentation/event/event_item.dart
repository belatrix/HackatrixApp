import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/presentation/util/theme.dart';

typedef void OnTapItemCallback(Event item);

class HomeItem extends StatelessWidget {
  HomeItem(this._event, {this.callback});

  final Event _event;
  final OnTapItemCallback callback;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    var imageHero = new Hero(
      tag: "${_event.id}",
      child: new CachedNetworkImage(
        imageUrl: _event.image,
        placeholder: new LinearProgressIndicator(),
        fit: BoxFit.cover,
        height: _event.isGoing ? 194.0 : 168.0,
        width: MediaQuery.of(context).size.width,
      ),
    );

    return new Stack(children: <Widget>[
      new Card(
          key: new Key("${_event.id}"),
          child: new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                imageHero,
                new Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Text(
                        _event.isUpcoming
                            ? "Próximamente".toUpperCase()
                            : _event.isGoing ? "En Marcha".toUpperCase() : "".toUpperCase(),
                        style: CompanyTextStyle.Overline,
                        maxLines: 1,
                      ),
                      new SizedBox(
                        height: 6.0,
                      ),
                      new Text(
                        _event.isGoing?_event.title:_event.title.replaceAll("Hackatrix ", ""),
                        style: CompanyTextStyle.H6,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                      new SizedBox(
                        height: 12.0,
                      ),
                      new Text(
                        _event.details,
                        style: textTheme.body2.apply(
                          color: Colors.black54,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
      new Positioned.fill(
        child: new Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => callback(_event),
          ),
        ),
      ),
    ]);
  }
}
