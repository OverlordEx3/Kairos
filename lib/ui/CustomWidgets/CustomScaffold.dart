import 'package:flutter/material.dart';
import 'CustomDrawer.dart';
import 'CustomAppbar.dart';
import '../NotImplemented.dart' show notImplemented;

class CustomScaffold extends Scaffold {
  CustomScaffold(
      {Key key,
      FloatingActionButton fab,
      Widget body,
      @required BuildContext context})
      : super(
            key: key,
            floatingActionButton: fab,
            body: body,
            drawer: CustomDrawer(context: context),
            appBar: CustomAppbar(context: context, title: Text("Kairos")));
}
