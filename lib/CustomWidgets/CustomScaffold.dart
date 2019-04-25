import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'CustomAppbar.dart';
import 'NotImplemented.dart' show notImplemented;

class CustomScaffold extends Scaffold {
  CustomScaffold(
      {Key key,
      Widget fab,
      Widget body,
      @required BuildContext context,
        FloatingActionButtonLocation location,
      Widget bottomNavBar})
      : super(
            key: key,
            floatingActionButton: fab,
            floatingActionButtonLocation: location,
            body: body,
            drawer: KairosAppDrawer(),
            appBar: CustomAppbar(context: context, title: Text("Kairos")),
            bottomNavigationBar: bottomNavBar);
}
