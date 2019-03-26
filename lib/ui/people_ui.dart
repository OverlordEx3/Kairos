import 'package:flutter/material.dart';

import '../blocs/people_bloc.dart';
import '../models/people_model.dart';

/* Other related UIs */
import 'people_card.dart';
import 'people_listitem.dart';

class PeopleUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PeopleUIState();
  }
}

class PeopleUIState extends State<PeopleUI> {
  /* TODO Mocked value */
  /* TODO fetch value from storage */
  bool _viewAsList = true;
  final Widget _notImplemented = new SnackBar(
    content: Text("No implementado"),
    duration: Duration(seconds: 5),
  );

  @override
  initState() {
    super.initState();
    bloc.fetchAllPeople();
  }

  @override
  dispose() {
    bloc.dispose();
    super.dispose();
  }

  bool _uiViewAsList() {
    return _viewAsList;
  }

  Icon _getIconByViewState(bool viewState) {
    return Icon(viewState == true ? Icons.view_list : Icons.view_agenda);
  }

  /* Widget body */
  Widget _bodyBuilder(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: StreamBuilder(
            stream: bloc.AllPeople,
            builder: (context, AsyncSnapshot<List<PeopleModel>> snapshot) {
              if (snapshot.hasData) {
                return buildItems(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: new CircularProgressIndicator());
            },
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Kairos",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        elevation: 10.0,
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.search),
                onPressed: (() =>
                    {Scaffold.of(context).showSnackBar(_notImplemented)}));
          }),
          Builder(builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: (() =>
                    {Scaffold.of(context).showSnackBar(_notImplemented)}));
          }),
          Builder(builder: (BuildContext context) {
            return IconButton(
                icon: _getIconByViewState(_uiViewAsList()),
                onPressed: (() =>
                    {Scaffold.of(context).showSnackBar(_notImplemented)}));
          })
        ],
      ),
      body: _bodyBuilder(context),
      floatingActionButton: new FloatingActionButton(
        onPressed: (() => {Scaffold.of(context).showSnackBar(_notImplemented)}),
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        elevation: 5.0,
        child: ListView(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
              leading: Icon(Icons.home),
              title: Text("Inicio"),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
              leading: Icon(Icons.group),
              title: Text("Listado"),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
              leading: Icon(Icons.calendar_today),
              title: Text("Asistencia"),
              onTap: (() =>
                  {Scaffold.of(context).showSnackBar(_notImplemented)}),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
              leading: Icon(Icons.attach_money),
              title: Text("Cobros"),
              onTap: (() =>
                  {Scaffold.of(context).showSnackBar(_notImplemented)}),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
              leading: Icon(Icons.help),
              title: Text("Acerca de"),
              onTap: (() =>
                  {Scaffold.of(context).showSnackBar(_notImplemented)}),
            ),
          ],
        ),
      ),
    );
    return null;
  }

  Widget buildItems(AsyncSnapshot<List<PeopleModel>> snapshot) {
    if (_viewAsList == true) {
      return new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return PeopleListItem(snapshot.data[index]);
        },
        itemCount: snapshot.data.length,
      );
    } else {
      return new GridView.builder(
        itemCount: snapshot.data.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return PeopleCard(snapshot.data[index]);
        },
      );
    }
  }
}
