import 'package:flutter/material.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_row_extended_text.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_row_link.dart';
import 'package:hackatrix/presentation/util/custom_widgets/custom_row_single_text.dart';
import 'package:intl/intl.dart';

class EventInformationPage extends StatelessWidget {
  final Event _event;

  EventInformationPage(this._event);

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 56.0),
      child: Divider(
        height: 1.0,
        color: Colors.black26,
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    List<Widget> options = List<Widget>();

    options.add(CustomRowSingleText(
        value: new DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(_event.datetime)),
        caption: "Fecha",
        icon: Icon(
          Icons.today,
          color: Colors.black54,
          size: 24.0,
        )));
    if (_event.registerLink.isNotEmpty) {
      options.add(CustomRowLink(
          value: "Website Oficial",
          caption: "Link",
          link: _event.registerLink,
          icon: Icon(
            Icons.language,
            color: Colors.black54,
            size: 24.0,
          )));
    }
    options.add(_buildDivider());
    options.add(CustomRowExtendedText(
      value: _event.details,
      caption: "Descripción",
      icon: null,
    ));
    if (_event.address.isNotEmpty) {
      options.add(_buildDivider());
      options.add(CustomRowSingleText(
          value: _event.address,
          caption: "Lugar",
          icon: Icon(
            Icons.place,
            color: Colors.black54,
            size: 24.0,
          )));
    }

    return options;
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Container(
        color: Colors.white,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildContent(context),
        ),
      ),
    );
  }
}
