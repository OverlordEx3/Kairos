import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'NotImplemented.dart' show notImplemented;

class CustomAppbar extends AppBar {

  CustomAppbar({Key key, Widget title, @required BuildContext context}) : super(key: key, title: title,
  actions: <Widget>[
    IconButton(icon: Icon(Icons.search),
    onPressed: () => notImplemented(context)),
    IconButton(icon: Icon(Icons.more_vert),
    onPressed: () => notImplemented(context))
  ]);
}