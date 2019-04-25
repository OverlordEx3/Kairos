import 'package:flutter/material.dart';
import 'NotImplemented.dart' show notImplemented;

class KairosAppDrawer extends StatelessWidget {
  final double elevation;
  final Key key;
  KairosAppDrawer({this.elevation = 16.0, this.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      elevation: this.elevation,
      key: key,
      child: SafeArea(
          child: ListView(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                leading: Icon(Icons.home),
                title: Text("Inicio"),
                onTap: () => Navigator.of(context).pushReplacementNamed('/'),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                leading: Icon(Icons.group),
                title: Text("Listado"),
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed('/List'),
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
                  onTap: () => notImplemented(context)),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(),
              ),
              ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                  leading: Icon(Icons.help),
                  title: Text("Acerca de"),
                  onTap: () => notImplemented(context))
            ],
          )
      ),
    );
  }
}