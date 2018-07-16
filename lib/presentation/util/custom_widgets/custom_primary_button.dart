import 'package:flutter/material.dart';
import 'package:hackatrix/presentation/util/theme.dart';

class CustomPrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomPrimaryButton({
    this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: CompanyColors.orange,
        highlightColor: CompanyColors.orange[700],
        splashColor: CompanyColors.orange[700],
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