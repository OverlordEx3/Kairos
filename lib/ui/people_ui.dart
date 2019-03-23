import 'package:flutter/material.dart';

import '../blocs/people_bloc.dart';
import '../models/people_model.dart';

/* Other related UIs */
import 'people_card.dart';

class PeopleListUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PeopleUI();
  }
}

class PeopleUI extends State<PeopleListUI> {
/*  Widget _buildItemAsCard(
      AsyncSnapshot<List<PeopleModel>> snapshot, int index) {
    return new Card(
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.deepPurple,
              backgroundImage: (snapshot.data.elementAt(index).Image != null
                  ? (new Image.memory(
                      snapshot.data.elementAt(index).Image.getBytes()))
                  : new Image.network(
                          "https://www.andiar.com/4186-thickbox_default/vinilo-brujula.jpg")
                      .image),
            ),
            new Text(
              snapshot.data.elementAt(index).Name +
                  " " +
                  snapshot.data.elementAt(index).Surname,
              textAlign: TextAlign.center,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            new Expanded(child: new Text(" Actually, no data. Sorry!"))
          ],
        ),
        Expanded(
            child: Align(
                child: Row(
          children: <Widget>[
            new IconButton(
              icon: new Icon(Icons.grade),
              onPressed: null,
              alignment: FractionalOffset.bottomRight,
            )
          ],
        )))
      ]),
    );
  }
*/
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
