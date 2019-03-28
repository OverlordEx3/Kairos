import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'AppScaffold.dart';

void notImplemented(BuildContext context) {
  final ScaffoldState appScaffold = AppScaffold.of(context);
  SnackBar snack = SnackBar(
      content: Text("No implementado",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30.0),
          textAlign: TextAlign.center),
      duration: Duration(seconds: 3));
  if (appScaffold != null) {
    appScaffold.showSnackBar(snack);
  }
}
