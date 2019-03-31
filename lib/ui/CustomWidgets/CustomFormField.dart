import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  Widget sufixWidget;
  Widget prefixWidget;
  String title;
  FormFieldValidator validator;
  FormFieldSetter onSaved;
  bool enabled;
  TextInputType inputType;
  InputDecoration decoration;

  CustomFormField(this.title,
      {this.enabled,
      this.validator,
      this.onSaved,
      this.inputType,
      this.decoration,
      this.prefixWidget,
      this.sufixWidget});

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
      child: ListTile(
      leading: widget.prefixWidget,
      title: Text(widget.title),
      trailing: widget.sufixWidget,
      enabled: widget.enabled,
      subtitle: TextFormField(
        decoration: widget.decoration,
        keyboardType: widget.inputType,
        onSaved: (value) {widget.onSaved(value);},
        validator: (value) {widget.validator(value);},
      ),
    )
    );
  }
}
