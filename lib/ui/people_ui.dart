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

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllPeople();
    return Scaffold(
      appBar: AppBar(
        title: new Text("Count me in!"),
      ),
      body: StreamBuilder(
        stream: bloc.AllPeople,
        builder: (context, AsyncSnapshot<PeopleModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
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
  Widget buildList(AsyncSnapshot<PeopleModel> snapshot) {
    return new GridView.builder(
      itemCount: snapshot.data.people.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        /* TODO Card layout */
        return Text(snapshot.data.people[index].Name +
            " " +
            snapshot.data.people[index].Surname);
      },
    );
  }
}
