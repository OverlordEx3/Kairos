
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

/* Models */
import '../models/people_model.dart';

class PeopleCard extends StatelessWidget {
  PeopleModel _people;

  PeopleCard(PeopleModel model) {
    _people = _people;
  }

  Widget _headerImage(BuildContext context) {
    return new Expanded(child: Row(
      children: <Widget>[
        CircleAvatar(),
        Text(""),
      ],
    ));
  }

  Widget _centeredData(BuildContext context) {
    return new Expanded(
        child: new Text("Hello!")
    );
  }

  Widget _bottomButtons(BuildContext context) {
    return new Expanded(
        child: new Row(
          children: <Widget>[
            RaisedButton(
              child: Text("Cuenta + 1"),
            )
          ],
        )
    );
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
      child: Expanded(
          child: Column(
            children: <Widget>[
              _headerImage(context),
              _centeredData(context),
              _bottomButtons(context),
            ],
          )
      )
    );
  }

}