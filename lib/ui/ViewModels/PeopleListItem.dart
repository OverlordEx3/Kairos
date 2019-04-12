import 'package:flutter/material.dart';
import '../../models/PeopleModel.dart';
import '../routes/PeopleCreateEditPage.dart'; /* TODO improve this. It's not good having such a mess with models */

class PeopleListItem extends StatefulWidget {
  PeopleModel _people;

  PeopleListItem(PeopleModel model) {
    _people = model;
  }

  @override
  _PeopleListItemState createState() => _PeopleListItemState();
}

class _PeopleListItemState extends State<PeopleListItem> {
  Widget _imageHeader(BuildContext context) {
    return new CircleAvatar(
      backgroundImage: Image.network(
              "https://previews.123rf.com/images/dmstudio/dmstudio1005/dmstudio100500024/7013643-br%C3%BAjula-de-vector-de-grunge-.jpg")
          .image,
      child: Text(widget._people.Name[0] + widget._people.Surname[0]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
        child: ListTile(
          onLongPress: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return PeopleEditCreatePage(true, people: widget._people);
          })),
      leading: _imageHeader(context),
      title: Text(
        widget._people.Name + " " + widget._people.Surname,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(widget._people.ShortBio),
      trailing: Checkbox(value: false, onChanged: null),
    )
    );
  }
}
