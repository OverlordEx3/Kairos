import 'package:flutter/material.dart';
import '../models/PeopleModel.dart' show People;

class PeopleListItem extends StatefulWidget {
  final People people;
  final bool shiftEnabled;
  final Function(BuildContext, People) onLongPress;
  final Function(int, bool) onChanged;

  PeopleListItem(this.people,
      {this.shiftEnabled = false, this.onLongPress, this.onChanged});

  @override
  _PeopleListItemState createState() => _PeopleListItemState();
}

class _PeopleListItemState extends State<PeopleListItem> {
  bool _value = false;
  String title;
  String subtitle;

  Widget _imageHeader(BuildContext context) {
    return new CircleAvatar(
      backgroundImage: Image.network(
              "https://previews.123rf.com/images/dmstudio/dmstudio1005/dmstudio100500024/7013643-br%C3%BAjula-de-vector-de-grunge-.jpg")
          .image,
      child: Text(this.widget.people.name[0] + this.widget.people.surname[0]),
    );
  }

  @override
  void initState() {
    super.initState();
    title = this.widget.people.name + " " + this.widget.people.surname;
    subtitle = this.widget.people.shortBio;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
      child: Material(
        elevation: 2.0,
        child: ListTile(
          leading: _imageHeader(context),
          title: Text(
            this.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(this.subtitle),
          onLongPress: () {
            if(this.widget.onLongPress != null) {
              return this.widget.onLongPress(context, this.widget.people);
            }
          },
          trailing: this.widget.shiftEnabled
              ? Checkbox(
                  value: _value,
                  onChanged: (value) {
                    if(this.widget.onChanged != null) {
                      this.widget.onChanged(this.widget.people.uid, value);
                    }
                    setState(() {
                      _value = value;
                    });
                  })
              : null,
        )));
  }
}
