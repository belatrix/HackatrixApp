import 'package:flutter/material.dart';

class MySecondaryButton extends OutlineButton {
  final VoidCallback onPressed;
  final String text;

  MySecondaryButton({this.text, this.onPressed})
      : super(
            child: new Text(
              text,
              style: new TextStyle(color: Colors.orange, fontSize: 16.0),
            ),
            borderSide: BorderSide(
              color: Colors.orange,
              width: 1.5,
            ),
            padding: EdgeInsets.symmetric(vertical: 14.0),
            color: Colors.white,
            onPressed: onPressed);
}
