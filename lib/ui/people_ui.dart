import 'package:flutter/material.dart';

import '../blocs/people_bloc.dart';
import '../models/people_model.dart';

/* Other related UIs */
import 'people_card.dart';
import 'people_listitem.dart';

class PeopleListUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PeopleUI();
  }
}

class PeopleUI extends State<PeopleListUI> {

  /* TODO Mocked value */
  final bool _viewAsList = true;

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllPeople();
    return Scaffold(
      appBar: AppBar(
        title: new Text("Kairos", style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w800),),
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
      floatingActionButton: new FloatingActionButton(onPressed: () => {}, child: Icon(Icons.add),),
    );
    return null;
  }

  /* TODO build as truly list */
  Widget buildItems(AsyncSnapshot<List<PeopleModel>> snapshot) {
    if(_viewAsList == true) {
      return new ListView.builder(itemBuilder: (BuildContext context, int index) {
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
          /* TODO Card layout */
          return PeopleCard(snapshot.data[index]);
        },
      );
    }
  }
}
