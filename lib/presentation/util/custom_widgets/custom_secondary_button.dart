import 'package:flutter/material.dart';
import 'package:hackatrix/presentation/util/theme.dart';

class CustomSecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomSecondaryButton({
    this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: CompanyColors.blue,
        highlightColor: CompanyColors.blue[700],
        splashColor: CompanyColors.blue[700],
        onPressed: onPressed,
        padding: EdgeInsets.all(12.0),
        child: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.button.apply(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}