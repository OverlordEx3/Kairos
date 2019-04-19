import 'package:flutter/material.dart';
import 'package:fab_menu/fab_menu.dart';
/* BLoCS */
import '../../blocs/PeopleBLoC.dart';
import '../../blocs/ShiftBloc.dart';

/* Models */
import '../../models/PeopleModel.dart';
import '../../models/ShiftModel.dart';
/* View models */
import '../ViewModels/PeopleListItem.dart';

import '../CustomWidgets/CustomScaffold.dart';

import 'PeopleCreateEditPage.dart';

const ListPagePath = '/List';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<MenuData> menuData = new List<MenuData>();
  bool shiftActive = false;

  @override
  initState() {
    super.initState();
    print("Initing!");
    peopleBloc.fetchAllPeople();

    menuData.add(MenuData(Icons.person, (context, menudata) {
      showAddPerson(context);
    }, labelText: "Nueva persona"));
    menuData.add(MenuData(Icons.calendar_today, (context, menudata) {
      /* TODO request new shift */
    }, labelText: "Nuevo turno"));
  }

  @override
  dispose() {
    print("Disposing!");
    peopleBloc.dispose();
    super.dispose();
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
            stream: peopleBloc.peopleStream,
            builder: (context, AsyncSnapshot<List<People>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    print(
                        "Error occurred at streambuilder: ${snapshot.error.toString()}");
                    print(
                        "Error type: ${snapshot.error.runtimeType.toString()}");
                    return Text("An error occurred. Please try again",
                        softWrap: true);
                  }

                  if (snapshot.hasData) {
                    print("Building ${snapshot.data.length} items.");
                    return buildItems(snapshot);
                  }
                  break;

                default:
                  print("No connection with stream. Awaiting...");
                  print("Connection state: ${snapshot.connectionState.toString()}");
                  return Center(child: new CircularProgressIndicator());
                  break;
              }
            },
          ))
        ],
      ),
    );
  }

  Future<bool> _showDismissibleConfirmation(
      BuildContext context, DismissDirection direction) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmar"),
            content: Text("¿Desea eliminar el item?"),
            actions: <Widget>[
              RaisedButton(
                textTheme: ButtonTextTheme.primary,
                child: Text("Eliminar"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                onPressed: () => Navigator.of(context).pop(true),
              ),
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          );
        });
  }

  void showAddPerson(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      /* Creating a new person */
      return new PeopleEditCreatePage(edit: false, people: null);
    }));
  }

  void showEditPerson(BuildContext context, People person) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      /* Creating a new person */
      return new PeopleEditCreatePage(edit: true, people: person);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      context: context,
      body: _bodyBuilder(context),
      fab: FabMenu(
        menus: menuData,
      ),
      location: fabMenuLocation,
    );
  }

  Widget buildItems(AsyncSnapshot<List<People>> snapshot) {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: Key(snapshot.data[index].hashCode.toString()),
          child: PeopleListItem(
              shiftEnabled: false,
              people: snapshot.data[index],
              onLongPress: showEditPerson),
          confirmDismiss: (direction) =>
              _showDismissibleConfirmation(context, direction),
          onDismissed: (direction) =>
              peopleBloc.deletePeople(snapshot.data[index]),
        );
      },
      itemCount: snapshot.data.length,
    );
  }
}
