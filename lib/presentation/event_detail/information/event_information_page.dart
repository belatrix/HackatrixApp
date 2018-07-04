import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class EventInformationPage extends StatelessWidget {
  final Event _event;

  EventInformationPage(this._event);

  @override
  Widget build(BuildContext context) {
    var styleChild = new TextStyle(color: Colors.grey, fontSize: 14.0);
    return new SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(_event.details,
                style: styleChild, textAlign: TextAlign.left),
            new HeaderText("Fecha"),
            new Text(new DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(_event.datetime)),style: styleChild,),
            new HeaderText("Lugar",),
            new Text(_event.address,style: styleChild,),
            new HeaderText("Link"),
            new RichText(
              text: new TextSpan(
                children: [
                new TextSpan(
                  text: _event.registerLink,
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () => _launchURL(_event.registerLink),
                ),
                ],
              ),
            ),
           
            new Padding(
              padding: EdgeInsets.only(bottom: 10.0),
            )
          ],
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  final String text;
  HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: new Text(text,
          style: new TextStyle(
            color: Colors.grey[800],
            fontSize: 14.0,
          ),
          textAlign: TextAlign.left),
    );
  }
}

_launchURL(final String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
