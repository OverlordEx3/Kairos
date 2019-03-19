import 'package:flutter/material.dart';

import '../blocs/people_bloc.dart';
import '../models/people_model.dart';

class PeopleListUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  {
    return PeopleUI();
  }
}

class PeopleUI extends State<PeopleListUI> {

  Widget _buildItemAsCard(AsyncSnapshot<List<PeopleModel>> snapshot, int index) {
    return new Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(snapshot.data.elementAt(index).Name[0] + snapshot.data.elementAt(index).Surname[0]),
                ),
                label: Text(snapshot.data.elementAt(index).Name + snapshot.data.elementAt(index).Surname),
              )
            ],
          ),
          Row(
            children: <Widget>[
              new Center(
                child: Text(snapshot.data.elementAt(index).Name + snapshot.data.elementAt(index).Surname),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2.0),
                child: IconButton(icon: new Icon(Icons.cloud_done), onPressed: () => {}),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllPeople();
    return Scaffold(
      appBar: AppBar(
        title: new Text("Count me in!"),
      ),
      body: StreamBuilder(
        stream: bloc.AllPeople,
        builder: (context, AsyncSnapshot<List<PeopleModel>> snapshot) {
          if (snapshot.hasData) {
            return buildItems(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: new CircularProgressIndicator());
        },
      ),
    );
    return null;
  }

  /* TODO build as truly list */
  Widget buildItems(AsyncSnapshot<List<PeopleModel>> snapshot) {
    return new GridView.builder(
      itemCount: snapshot.data.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        /* TODO Card layout */
        return _buildItemAsCard(snapshot, index);
      },
    );
  }
}
