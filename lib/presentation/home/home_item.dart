import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hackatrix/domain/model/event.dart';

typedef void OnTapItemCallBack(Event item);

class HomeItem extends StatelessWidget {
  HomeItem(this._event, {this.callBack});
  final Event _event;
  final OnTapItemCallBack callBack;

  @override
  Widget build(BuildContext context) {
    var imageHero = new Hero(
      tag: "${_event.id}",
      child: new CachedNetworkImage(
        imageUrl: _event.image,
        placeholder: new LinearProgressIndicator(),
        fit: BoxFit.cover,
      ),
    );

    return new Container(
        key: new Key("${_event.id}"),
        child: new Stack(children: <Widget>[
          new GridTile(
            child: imageHero,
            footer: new GridTileBar(
              title: new Text(_event.title, overflow: TextOverflow.clip,  style: new TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400
                )),
              backgroundColor: Colors.black38,
            ),
          ),
          new Positioned.fill(
              child: new Material(
                  color: Colors.transparent,
                  child: new InkWell(
                    onTap: () => callBack(_event),
                  ))),
        ]));
  }
}
