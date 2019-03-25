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
        children: <Widget>[
          /* Bar selecting view as card/list */
          Container(
            alignment: Alignment.centerRight,
            constraints: BoxConstraints(maxHeight: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: _getIconByViewState(_uiViewAsList()),
                    onPressed: () {
                      setState(() {
                        _viewAsList = _uiViewAsList() == true ? false : true;
                      });
                    },
                  )
                ],
              )
          ),
          Divider(),
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
      ),
      body: _bodyBuilder(context),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.add),
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
