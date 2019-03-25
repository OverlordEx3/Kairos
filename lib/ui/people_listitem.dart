import 'package:flutter/material.dart';

import '../models/people_model.dart';

class PeopleListItem extends StatelessWidget {
  PeopleModel _people;

  PeopleListItem(PeopleModel model) {
    _people = model;
  }

  ImageProvider _getImageFromModel() {

  }

  Widget _imageHeader(BuildContext context) {
    return new CircleAvatar(
      backgroundImage: Image.network(
              "https://previews.123rf.com/images/dmstudio/dmstudio1005/dmstudio100500024/7013643-br%C3%BAjula-de-vector-de-grunge-.jpg")
          .image,
      child: Text(_people.Name[0] + _people.Surname[0]),
    );
  }

  Widget _dataCenter(BuildContext context) {
    return new Expanded(
        child: Container(
            child: Column(
      children: <Widget>[
        new Text(
          _people.Name + " " + _people.Surname,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        new Text("Hello from Kairos as ListItem!")
      ],
    )));
  }

  Widget _buttons(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.plus_one),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: 0.7),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        padding: EdgeInsets.all(2.0),
        margin: EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _imageHeader(context),
            _dataCenter(context),
            _buttons(context),
          ],
        ));
  }
}
