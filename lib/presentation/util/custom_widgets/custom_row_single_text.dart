import 'package:flutter/material.dart';

class CustomRowSingleText extends StatelessWidget {
  final String value;
  final String caption;
  final Icon icon;

  const CustomRowSingleText({this.value, this.caption, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 72.0,
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
                    Text(value, maxLines: 1, style: Theme.of(context).textTheme.body1),
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
        ));
  }
}
