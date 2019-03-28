import 'package:flutter/material.dart';
import '../NotImplemented.dart' show notImplemented;

class CustomDrawer extends Drawer {
  CustomDrawer({Key key, double elevation: 16.0, @required BuildContext context})
      : assert(elevation != null && elevation >= 0.0),
        super(key: key, elevation: elevation,
      child: ListView(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
            leading: Icon(Icons.home),
            title: Text("Inicio"),
            onTap: () => Navigator.of(context).pushNamed('/'),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Divider(),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
            leading: Icon(Icons.group),
            title: Text("Listado"),
            onTap: () => Navigator.of(context).pushNamed('/List'),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
            leading: Icon(Icons.calendar_today),
            title: Text("Asistencia"),
            onTap: () => notImplemented(context),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
            leading: Icon(Icons.attach_money),
            title: Text("Cobros"),
              onTap: () => notImplemented(context)
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Divider(),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
            leading: Icon(Icons.help),
            title: Text("Acerca de"),
              onTap: () => notImplemented(context)
          )
        ],
      ));
}
