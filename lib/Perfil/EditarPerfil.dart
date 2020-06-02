import 'package:flutter/material.dart';
import 'package:flutterapp/Perfil/Perfil.dart';
import 'package:provider/provider.dart';

import 'package:flutterapp/Data/moor_database.dart';

class EditProfile extends StatefulWidget {
  EditProfile({@required this.id});

  String id;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateTime _dateTime;

  Future<void> setDate(UsuarioDAO dao) async{
    UsuarioData user = await dao.getUser(widget.id);
    //UsuarioData(id: user.id, nombre: user., edad: null, photoUrl: null, email: null)
  }

  Widget DateSel() {
    return Center(
        child: RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.indigo,
      padding: EdgeInsets.all(13.0),
      autofocus: true,
      child: Text(
        'Introducir fecha de nacimiento',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
      onPressed: () {
        showDatePicker(
                initialEntryMode: DatePickerEntryMode.input,
                helpText: "Introduzca su fecha de nacimiento",
                fieldLabelText: "Fecha",
                fieldHintText: "dd/mm/aaaa",
                errorFormatText: "Formato no válido",
                errorInvalidText: "El valor mínimo de la fecha es 1900",
                context: context,
                initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                firstDate: DateTime(1900),
                lastDate: DateTime.now())
            .then((date) {
          setState(() {
            _dateTime = date;
          });
        });
      },
    ));
  }

  Widget CambiarF(UsuarioDAO dao) {
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Colors.indigo,
        padding: EdgeInsets.all(13.0),
        autofocus: true,
        child: Text(
          'Cambiar',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        onPressed: () {
          dao.updateEdad(widget.id, _dateTime);
           Navigator.push(context,MaterialPageRoute(builder: (context) => MyProfile()));
        });
  }

  Widget ActualSelDate() {
    return Center(
      child: Text(
        _dateTime == null
            ? 'Todavía no has eligido fecha'
            : DateTimeToString(_dateTime),
        style: TextStyle(fontSize: 30, color: Colors.indigo),
        textAlign: TextAlign.center,
      ),
    );
  }

  String DateTimeToString(DateTime _dateTime) {
    String day = _dateTime.day.toString();
    String month = _dateTime.month.toString();
    String year = _dateTime.year.toString();
    return day + "/" + month + "/" + year;
  }

  
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    //setDate(database.usuarioDAO);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Cambio de F. Nacimiento'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            DateSel(),
            Padding(
              padding: EdgeInsets.all(40),
            ),
            ActualSelDate(),
            Padding(
              padding: EdgeInsets.all(40),
            ),
            CambiarF(database.usuarioDAO)
          ],
        ),
      ),
    );
  }
}
