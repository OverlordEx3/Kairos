
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/PeopleModel.dart';
/* Models */


class PeopleCard extends StatelessWidget {
  PeopleModel _people;

  PeopleCard(PeopleModel model) {
    _people = model;
  }

  Widget _headerImage(BuildContext context) {
    return new Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(2.0),
        margin: EdgeInsets.all(1.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: Image
                  .network(
                  "https://previews.123rf.com/images/dmstudio/dmstudio1005/dmstudio100500024/7013643-br%C3%BAjula-de-vector-de-grunge-.jpg")
                  .image,
              child: Text(_people.Name[0] + _people.Surname[0]),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                _people.Name + " " + _people.Surname,
                textAlign: TextAlign.left,
              ),
            )
          ],
        )
    )
    );
  }

  Widget _centeredData(BuildContext context) {
    return new Expanded(
        child: new Text("Hello!",
        textAlign: TextAlign.center)
    );
  }

  Widget _bottomButtons(BuildContext context) {
    return new Expanded(
      child: Container(
        padding: EdgeInsets.all(0.5),
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(right: 2.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.plus_one),
              onPressed: (() => {}),
              tooltip: "Cuenta la asistencia",
            )
          ],
        )
    )
    );
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
          child: Column(
            children: <Widget>[
              _headerImage(context),
              _centeredData(context),
              _bottomButtons(context),
            ],
          )
    );
  }

}