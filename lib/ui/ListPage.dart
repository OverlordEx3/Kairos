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
    return StreamBuilder(
        stream: shiftBloc.shiftStatusStream,
        initialData: shiftBloc.initialStatus,
        builder: (BuildContext context, AsyncSnapshot<ShiftStatus> snapshot) {
          bool shiftIsActive = false;
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                if (snapshot.data == ShiftStatus.SHIFT_NEW ||
                    snapshot.data == ShiftStatus.SHIFT_OPEN) {
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

          return Scaffold(
            drawer: const KairosAppDrawer(),
            appBar: AppBar(
              title: const Text("Kairos"),
              centerTitle: true,
            ),
            floatingActionButton:
                shiftIsActive == true ? null : FabMenu(menus: menuData),
            floatingActionButtonLocation: fabMenuLocation,
            bottomNavigationBar: shiftIsActive == false ? null : BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.check), onPressed: () => shiftBloc.closeShift()),
                  IconButton(icon: Icon(Icons.cancel), onPressed: () => shiftBloc.cancelShift())
                ],
              ),
            ),
            body: ListPageInheritedWidget(
              shiftIsActive: shiftIsActive,
              setAttendance: setAttendance,
              editPerson: showEditPerson,
              child: _ListPageBodyPeopleBuild(),
            ),
          );
        });
  }

  void showAddPerson(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      /* Creating a new person */
      return new PeopleEditCreatePage(edit: false, people: null);
    }));
  }

  void setAttendance(int id, bool attendance) {
    shiftBloc.setAttendant(id, attendance);
  }

  void showEditPerson(BuildContext context, People person) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      /* Creating a new person */
      return new PeopleEditCreatePage(edit: true, people: person);
    }));
  }
}

class _ListPageBodyPeopleBuild extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListPageBodyPeopleBuildState();
}

class _ListPageBodyPeopleBuildState extends State<_ListPageBodyPeopleBuild> {
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
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
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
                          return _ListPageBodyListItemsBuild(snapshot.data);
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
                ),
              )
            ]));
  }
}

class _ListPageBodyListItemsBuild extends StatefulWidget {
  final List<People> data;
  _ListPageBodyListItemsBuild(this.data);

  @override
  _ListPageBodyListItemsBuildState createState() =>
      _ListPageBodyListItemsBuildState();
}

class _ListPageBodyListItemsBuildState
    extends State<_ListPageBodyListItemsBuild> {
  @override
  Widget build(BuildContext context) {
    final inheritedListPageParent = ListPageInheritedWidget.of(context);
    return ListView.builder(
      itemCount: widget.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          direction: DismissDirection.horizontal,
          key: Key(widget.data[index].hashCode.toString()),
          child: PeopleListItem(widget.data[index],
              shiftEnabled: inheritedListPageParent.shiftIsActive,
              onLongPress: inheritedListPageParent.editPerson,
              onChanged: inheritedListPageParent.setAttendance),
          confirmDismiss: (direction) =>
              showDismissibleConfirmation(context, direction),
          onDismissed: (direction) => peopleBloc.delete(widget.data[index]),
        );
      },
    );
  }

  Future<bool> showDismissibleConfirmation(
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

class ListPageInheritedWidget extends InheritedWidget {
  final Function(BuildContext, People) editPerson;
  final Function(int, bool) setAttendance;
  final bool shiftIsActive;

  ListPageInheritedWidget(
      {Widget child, this.editPerson, this.setAttendance, this.shiftIsActive})
      : super(child: child);

  @override
  bool updateShouldNotify(ListPageInheritedWidget oldWidget) {
    if (this.editPerson != oldWidget.editPerson ||
        this.setAttendance != oldWidget.setAttendance ||
        this.shiftIsActive != oldWidget.shiftIsActive) {
      return true;
    }
    return false;
  }

  static ListPageInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ListPageInheritedWidget);
  }
}
