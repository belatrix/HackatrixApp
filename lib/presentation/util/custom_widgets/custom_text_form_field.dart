import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {this.fieldKey,
      this.hintText,
      @required this.labelText,
      this.helperText,
      this.onSaved,
      this.obscureText = false,
      this.maxLines,
      this.validator,
      this.textInputType = TextInputType.text,
      this.onFieldSubmitted,
      this.controller});

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final int maxLines;
  final bool obscureText;
  final TextInputType textInputType;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;

  @override
  _CustomTextFormFieldState createState() => new _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      maxLines: widget.maxLines,
      autovalidate: false,
      autocorrect: false,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      onSaved: widget.onSaved,
      validator: widget.validator,
      style: Theme.of(context).textTheme.subhead,
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.controller,
      decoration: new InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
      ),
    );
  }
}
