import 'package:flutter/material.dart';
import '../../models/PeopleModel.dart';

typedef ItemGestureCallback(BuildContext widgetContext, People editingPeople);

class PeopleListItem extends StatefulWidget {
	final People people;
	final bool shiftEnabled;
	final ItemGestureCallback onLongPress;

	PeopleListItem({this.people, this.shiftEnabled, this.onLongPress});

	@override
	_PeopleListItemState createState() => _PeopleListItemState();
}

class _PeopleListItemState extends State<PeopleListItem> {
	Widget _imageHeader(BuildContext context) {
		return new CircleAvatar(
			backgroundImage: Image.network(
					"https://previews.123rf.com/images/dmstudio/dmstudio1005/dmstudio100500024/7013643-br%C3%BAjula-de-vector-de-grunge-.jpg")
					.image,
			child: Text(widget.people.name[0] + widget.people.surname[0]),
		);
	}

	@override
	Widget build(BuildContext context) {
		return Card(
				elevation: 2.0,
				child: ListTile(
					onLongPress: () {
						widget?.onLongPress(context, widget.people);
					},
					leading: _imageHeader(context),
					title: Text(
						widget.people.name + " " + widget.people.surname,
						style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
					),
					subtitle: Text(widget.people.shortBio),
					trailing: widget.shiftEnabled ? Checkbox(value: false, onChanged: null) : null,
				)
		);
	}
}
