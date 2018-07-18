import 'package:flutter/material.dart';
import 'package:hackatrix/presentation/util/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomRowLink extends StatelessWidget {
  final String value;
  final String caption;
  final String link;
  final Icon icon;

  const CustomRowLink({this.value, this.caption, this.link, this.icon});

  _launchURL(final String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _launchURL(link);
        },
        child: Container(
            height: 72.0,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: icon,
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 56.0),
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(value,
                            maxLines: 1, style: Theme.of(context).textTheme.body1.apply(color: CompanyColors.blue)),
                        Text(
                          caption,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
