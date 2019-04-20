import 'package:flutter/material.dart';
import '../../models/PeopleModel.dart';

typedef ItemGestureCallback(BuildContext widgetContext, People editingPeople);

class PeopleListItem extends StatelessWidget {
	final People people;
	final bool shiftEnabled;
	final ItemGestureCallback onLongPress;

	PeopleListItem({this.people, this.shiftEnabled, this.onLongPress});

	Widget _imageHeader(BuildContext context) {
		return new CircleAvatar(
			backgroundImage: Image.network(
					"https://previews.123rf.com/images/dmstudio/dmstudio1005/dmstudio100500024/7013643-br%C3%BAjula-de-vector-de-grunge-.jpg")
					.image,
			child: Text(this.people.name[0] + this.people.surname[0]),
		);
	}

	@override
	Widget build(BuildContext context) {
		return Card(
				elevation: 2.0,
				child: ListTile(
					onLongPress: () => this?.onLongPress(context, this.people),
					leading: _imageHeader(context),
					title: Text(
						this.people.name + " " + this.people.surname,
						style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
					),
					subtitle: Text(this.people.shortBio?? ""),
					trailing: this.shiftEnabled ? Checkbox(value: false, onChanged: null) : null,
				)
		);
	}
}