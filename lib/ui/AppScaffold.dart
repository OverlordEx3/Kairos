import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class AppScaffold extends InheritedWidget {
  const AppScaffold({Key key, @required Widget child}) : assert(child != null), super(key: key, child: child);

  /* Inherits scaffold from ancestor TODO document */
  static ScaffoldState of(BuildContext context) {
    return context.ancestorInheritedElementForWidgetOfExactType(AppScaffold)?.ancestorStateOfType(const TypeMatcher<AppScaffold>());
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}