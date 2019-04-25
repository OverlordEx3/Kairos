import 'package:flutter/material.dart';
import 'package:fab_menu/fab_menu.dart';
/* BLoCS */
import '../blocs/PeopleBLoC.dart' show peopleBloc;
import '../blocs/ShiftBloc.dart' show shiftBloc;

/* Models */
import '../models/PeopleModel.dart';
import '../models/ShiftModel.dart' show ShiftStatus;

/* View models */
import 'package:count_me_in/CustomWidgets/PeopleListItem.dart';
import 'package:count_me_in/ui/PeopleCreateEditPage.dart';

import '../CustomWidgets/AppDrawer.dart';

const ListPagePath = '/List';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<MenuData> menuData = new List<MenuData>();

  @override
  initState() {
    super.initState();

    menuData.add(MenuData(Icons.person, (context, data) {
      showAddPerson(context);
    }, labelText: "Nueva persona"));
    menuData.add(MenuData(Icons.calendar_today, (context, data) {
      shiftBloc.requestNewShift();
    }, labelText: "Nuevo turno"));
  }

  @override
  dispose() {
    shiftBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kairos'), centerTitle: true,),
      drawer: KairosAppDrawer(),
      floatingActionButton: FabMenu(menus: menuData),
      floatingActionButtonLocation: fabMenuLocation,
      body: ListPageBody(),
    );
  }

  void showAddPerson(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      /* Creating a new person */
      return new PeopleEditCreatePage(edit: false, people: null);
    }));
  }
}

class ListPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: StreamBuilder(
                  stream: shiftBloc.shiftStatusStream,
                  initialData: shiftBloc.initialStatus,
                  builder: (BuildContext context, AsyncSnapshot<ShiftStatus> snapshot) {
                    return ListPageBodyShiftListBuilder(snapshot, setAttendance);
                  }
              )
          )
        ],
      ),
    );
  }

  void setAttendance(int id, bool attendance) {
    shiftBloc.setAttendant(id, attendance);
  }
}

class ListPageBodyShiftListBuilder extends StatelessWidget {
  final AsyncSnapshot<ShiftStatus> snapshot;
  final Function(int, bool) setAttendance;

  ListPageBodyShiftListBuilder(this.snapshot, [this.setAttendance]);

  @override
  Widget build(BuildContext context) {
    bool shiftIsActive = false;
    switch(this.snapshot.connectionState) {
      case ConnectionState.active:
      case ConnectionState.done:
        if(this.snapshot.hasData) {
          if(this.snapshot.data == ShiftStatus.SHIFT_NEW
              || this.snapshot.data == ShiftStatus.SHIFT_OPEN) {
            shiftIsActive = true;
          } else {
            shiftIsActive = false;
          }
        }
        break;
      default:
        shiftIsActive = false;
        break;
    }

    return ListPageBodyPeopleBuild(shiftIsActive, this.setAttendance);
  }
}

class ListPageBodyPeopleBuild extends StatefulWidget{
  final bool shiftIsActive;
  final Function(int, bool) setAttendance;
  ListPageBodyPeopleBuild(this.shiftIsActive, [this.setAttendance]);

  @override
  State<StatefulWidget> createState() => _ListPageBodyPeopleBuildState();
}

class _ListPageBodyPeopleBuildState extends State<ListPageBodyPeopleBuild> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
              return ListPageBodyListItemsBuild(snapshot, this.widget.shiftIsActive, this.widget.setAttendance);
            }
            break;

          default:
            print("No connection with stream. Awaiting...");
            print(
                "Connection state: ${snapshot.connectionState.toString()}");
            return Center(child: new CircularProgressIndicator());
            break;
        }
      },
    );
  }
}

class ListPageBodyListItemsBuild extends StatefulWidget {
  final AsyncSnapshot<List<People>> snapshot;
  final bool shiftActive;
  final Function(int, bool) setAttendance;
  ListPageBodyListItemsBuild(this.snapshot, this.shiftActive, [this.setAttendance]);

  @override
  _ListPageBodyListItemsBuildState createState() => _ListPageBodyListItemsBuildState();
}

class _ListPageBodyListItemsBuildState extends State<ListPageBodyListItemsBuild> {
  @override
  void initState() {
    super.initState();
    peopleBloc.retrieveAll();
  }

  @override
  void dispose() {
    peopleBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          direction: DismissDirection.horizontal,
          key: Key(widget.snapshot.data[index].hashCode.toString()),
          child: PeopleListItem(widget.snapshot.data[index],
              shiftEnabled: widget.shiftActive,
              onLongPress: showEditPerson,
              onChanged: this.widget.setAttendance),
          confirmDismiss: (direction) =>
              _showDismissibleConfirmation(context, direction),
          onDismissed: (direction) => peopleBloc.delete(widget.snapshot.data[index]),
        );
      },
    );
  }

  void showEditPerson(BuildContext context, People person) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      /* Creating a new person */
      return new PeopleEditCreatePage(edit: true, people: person);
    }));
  }

  Future<bool> _showDismissibleConfirmation(
      BuildContext context, DismissDirection direction) async {
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
}
