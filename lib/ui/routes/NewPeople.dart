import 'package:flutter/material.dart';
import '../CustomWidgets/CustomFormField.dart';

class newPeople extends StatefulWidget {
  @override
  _newPeopleState createState() => _newPeopleState();
}

class _newPeopleState extends State<newPeople> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  void _showDateTimePicker(BuildContext context) async {
    DateTime birthdate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1907),
        lastDate: DateTime.now());

    setState(() {});
  }

  Widget _nameField(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
        child: TextFormField(
          decoration: InputDecoration(labelText: "Nombre"),
          validator: (value) {
            if (value.length == 0) {
              return "El campo no puede estar vacío";
            }
          },
        ));
  }

  Widget _SurnameField(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: "Apellido"),
        validator: (value) {
          if (value.length == 0) {
            return "El campo no puede estar vacío";
          }
        },
      ),
    );
  }

  Widget _idField(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: "Documento"),
        validator: (value) {
          if (value.length == 0) {
            return "El campo no puede estar vacío";
          }
        },
      ),
    );
  }

  Widget _shortBio(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
      child: TextFormField(
        maxLines: null,
        decoration:
            InputDecoration(labelText: "Observaciones", helperText: "Opcional"),
      ),
    );
  }

  Widget _showDateTimeField(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 2.0, bottom: 3.0),
      child: TextFormField(
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
            labelText: "Fecha de nacimiento",
            suffix: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _showDateTimePicker(context))),
        initialValue: DateTime.now().toString(),
      ),
    );
  }

  Widget _buttonCTA(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          child: Text("Añadir"),
          color: Colors.blueAccent,
          onPressed: () {
            final saved = _validateAndSave();
            if (saved) {
              /* Pop result */
            }
          },
        ),
        RaisedButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  bool _validateAndSave() {
    bool isValid = formKey.currentState.validate();
    if (isValid) {
      formKey.currentState.save();
      return true;
    } else {
      return false;
    }
  }

  /* TODO Build with sections */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title: Text("Agregar persona"),
      ),
      body: Container(
          margin: EdgeInsets.all(15.0),
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                _nameField(context),
                _SurnameField(context),
                _idField(context),
                _showDateTimeField(context),
                _shortBio(context),
                _buttonCTA(context),
              ],
            ),
          )),
    );
  }
}
