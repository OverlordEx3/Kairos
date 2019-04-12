import 'package:flutter/material.dart';
import 'CustomDrawer.dart';
import 'CustomAppbar.dart';
import '../NotImplemented.dart' show notImplemented;

class CustomScaffold extends Scaffold {
  CustomScaffold(
      {Key key,
      Widget fab,
      Widget body,
      @required BuildContext context,
        FloatingActionButtonLocation location})
      : super(
            key: key,
            floatingActionButton: fab,
            floatingActionButtonLocation: location,
            body: body,
            drawer: CustomDrawer(context: context),
            appBar: CustomAppbar(context: context, title: Text("Kairos")));
}
