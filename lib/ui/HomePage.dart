import 'package:flutter/material.dart';

import '../CustomWidgets/CustomScaffold.dart';
import 'package:count_me_in/CustomWidgets/NotImplemented.dart' as notImplemented;

const HomePath = '/';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        context: context,
        body: Center(child: Text("No implementado, sorry!")),
        fab: FloatingActionButton(
          onPressed: (() => {notImplemented.notImplemented(context)}),
          child: Icon(Icons.add),
        ));
  }
}
