import 'package:flutter/material.dart';

class MyPrimaryButton extends RaisedButton {
  final VoidCallback onPressed;
  final String text;

  MyPrimaryButton({this.text, this.onPressed})
      : super(
            child: new Text(
              text,
              style: new TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 14.0),
            color: Colors.orange,
            onPressed: onPressed);
}
