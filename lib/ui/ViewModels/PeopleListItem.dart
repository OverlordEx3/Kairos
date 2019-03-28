import 'package:flutter/material.dart';

import '../../models/people_model.dart';

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
    return Card(
      elevation: 2.0,
        child: ListTile(
      leading: _imageHeader(context),
      title: Text(
        _people.Name + " " + _people.Surname,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      subtitle: Text("Hello from Kairos as ListItem!"),
      trailing: Checkbox(value: false, onChanged: null),
    )
    );
  }
}
