import 'package:flutter/material.dart';
import '../../blocs/PeopleBLoC.dart';
import '../../models/PeopleModel.dart';

class PeopleEditCreatePage extends StatefulWidget {
  bool edit;
  PeopleModel people;

  PeopleEditCreatePage(bool edit, {PeopleModel people})
      : assert((edit == true && people != null) || edit == false) {
    this.edit = edit;
    this.people = people;
  }

  @override
  _PeopleEditCreatePageState createState() => _PeopleEditCreatePageState();
}

class _PeopleEditCreatePageState extends State<PeopleEditCreatePage> {
  /* Handle form state (validations, saving, etc */
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final InputBorder _defaultBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)));
  TextEditingController _nameTextController;
  TextEditingController _surnameTextController;
  TextEditingController _idController;
  TextEditingController _miscController;

  String _buttonLabel = "";
  String _title = "";

  _PeopleEditCreatePageState();

  @override
  initState() {
    super.initState();

    _nameTextController = new TextEditingController(
        text: widget.edit == true ? widget.people.Name : "");
    _surnameTextController = new TextEditingController(
        text: widget.edit == true ? widget.people.Surname : "");
    _idController = new TextEditingController(
        text: widget.edit == true ? widget.people.ID.toString() : "");
    _miscController = new TextEditingController(
        text: widget.edit == true ? widget.people.ShortBio : "");

    _buttonLabel = widget.edit ? "Editar" : "Crear";
    _title = widget.edit ? "Editar persona" : "Nueva persona";
  }

  Widget _nameField(BuildContext context) {
    return TextFormField(
      controller: _nameTextController,
      maxLength: 15,
      decoration: InputDecoration(labelText: "Nombre", border: _defaultBorder),
      validator: (name) {
        if (name.isEmpty) return 'El campo no puede estar vacío';
      },
    );
  }

  Widget _surnameField(BuildContext context) {
    return TextFormField(
      controller: _surnameTextController,
      maxLength: 15,
      decoration:
          InputDecoration(labelText: "Apellido", border: _defaultBorder),
      validator: (name) {
        if (name.isEmpty) return 'El campo no puede estar vacío';
      },
    );
  }

  Widget _idField(BuildContext context) {
    return TextFormField(
      controller: _idController,
      keyboardType: TextInputType.number,
      maxLength: 15,
      decoration:
          InputDecoration(labelText: "Documento", border: _defaultBorder),
      validator: (id) {
        if (id.isEmpty) return "El campo no puede estar vacío";
        if (int.tryParse(id) == null) return 'Error en el campo';
      },
    );
  }

  Widget _shortBioField(BuildContext context) {
    return TextFormField(
      controller: _miscController,
      maxLines: null,
      maxLength: 160,
      decoration: InputDecoration(
          labelText: "Observaciones",
          helperText: "Opcional",
          border: _defaultBorder),
      validator: (value) => null,
    );
  }

  Widget _sectionField(BuildContext context) {
    return null;
  }

  Widget _buttonCTA(BuildContext context) {
    return new Container(
        margin: EdgeInsets.only(top: 30.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text("Cancelar", style: TextStyle(color: Colors.black87)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text(_buttonLabel,
                  style: Theme.of(context).primaryTextTheme.button),
              color: Theme.of(context).accentColor,
              onPressed: () {
                final saved = validateAndSave();
                if (saved) {
                  /* Pop a flag asking for re-fetching */
                  Navigator.of(context).pop();
                }
              },
              textTheme: ButtonTextTheme.normal,
            )
          ],
        ));
  }

  bool validateAndSave() {
    bool isValid = formKey.currentState.validate();
    if (isValid != true) return false;

    /* Check operation*/
    if (widget.edit == true) {
      /* Request editing */
      peopleBloc.updatePeople(widget.people);
    } else {
      /* Save new one */
      peopleBloc.submitNewPeople(
          _nameTextController.text,
          _surnameTextController.text,
          _miscController.text,
          int.tryParse(_idController.text) ?? -1);
    }

    return true;
  }

  /* TODO Build with sections */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title: Text(_title),
      ),
      body: Container(
          child: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            _nameField(context),
            _surnameField(context),
            _idField(context),
            _shortBioField(context),
            _buttonCTA(context),
          ],
        ),
      )),
    );
  }
}
