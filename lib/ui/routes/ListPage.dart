import 'package:flutter/material.dart';
/* BLoCS */
import '../../blocs/people_bloc.dart';
/* Models */
import '../../models/people_model.dart';
/* View models */
import '../ViewModels/PeopleCard.dart';
import '../ViewModels/PeopleListItem.dart';

import '../CustomWidgets/CustomScaffold.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
    return CustomScaffold(
      context: context,
      body: _bodyBuilder(context),
      fab: new FloatingActionButton(
        onPressed: (() => {Scaffold.of(context).showSnackBar(_notImplemented)}),
        child: Icon(Icons.add),
      ),
    );
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
