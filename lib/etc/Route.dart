import 'package:flutter/material.dart';

void ChangeRoute(BuildContext context, String routeName)
{
  bool isCurrent = false;
  /* Close Drawer if opened */
  if(Scaffold.of(context).isDrawerOpen == true) {
    Navigator.of(context).pop();
  }

  Navigator.popUntil(context, (currentRoute) {
    if(currentRoute.isCurrent) {
      isCurrent = true;
    }

    return true;
  });
}