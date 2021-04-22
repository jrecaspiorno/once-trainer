import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:provider/provider.dart';

import '../SignUpState.dart';

class DatePicker extends StatefulWidget {
  final TextInputType keyboardType;

  const DatePicker({Key key, this.keyboardType}) : super(key: key);
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _dateTime;
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Widget _dateBuilder(BuildContext context) {
    var state = Provider.of<LoginState>(context, listen: false);
    String name = state.getName();

    return Scaffold(
      body: Center(
        child: Consumer<LoginState>(
          builder: (BuildContext context, LoginState value, Widget child) {
            if (value.isLoading()) {
              return CircularProgressIndicator();
            } else {
              return child;
            }
          },
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              if (name == null) nameSel(),

              Padding(
                padding: EdgeInsets.all(40),
              ),

              dateSel(),

              Padding(
                padding: EdgeInsets.all(40),
              ),

              actualSelDate(),

              Padding(
                padding: EdgeInsets.all(40),
              ),

              buttoAccept(context),

              Padding(
                padding: EdgeInsets.all(15),
              ),

              //GotoLogin()
            ],
          ),
        ),
      ),
    );
  }

  Widget nameSel() {
    return Center(
      child: TextField(
        textAlign: TextAlign.center,
        controller: nameController,
        maxLength: 16,
        autocorrect: true,
        style: TextStyle(
          fontSize: 30,
          color: Colors.indigo,
        ),
        decoration: InputDecoration(
            alignLabelWithHint: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.indigo,
                  width: 3.0,
                  style: BorderStyle.solid,
                )),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.indigo,
                  width: 3.0,
                  style: BorderStyle.solid,
            )),
            hintText: "Introduzca su nombre"),
      ),
    );
  }

  Widget dateSel() {
    return Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Colors.indigo,
        padding: EdgeInsets.all(13.0),
        autofocus: false,
        child: Text(
          'Introduzca su fecha de nacimiento',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        onPressed: () {
          showDatePicker(
                  builder: (context, child) => Theme(
                        child: child,
                        data: ThemeData.light().copyWith(
                          primaryColor: Colors.indigo,
                          accentColor: Colors.indigo,
                          colorScheme: ColorScheme.light(
                              primary: const Color(0xFF3F51B5)),
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                      ),
                  initialEntryMode: DatePickerEntryMode.input,
                  helpText: "Introduzca su fecha de nacimiento",
                  fieldLabelText: "Fecha",
                  fieldHintText: "dd/mm/aaaa",
                  errorFormatText: "Formato no válido",
                  context: context,
                  errorInvalidText: "El valor mínimo de la fecha es 1900",
                  locale: Locale('es', 'ES'),
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now())
              .then((date) {
            setState(() {
              _dateTime = date;
            });
          });
        },
      ),
    );
  }

  Widget actualSelDate() {
    return Center(
      child: Text(
        _dateTime == null
            ? 'Todavía no has eligido fecha'
            : dateTimeToString(_dateTime),
        style: TextStyle(fontSize: 30, color: Colors.indigo),
        textAlign: TextAlign.center,
      ),
    );
  }
  bool validName(String name){
    if(name == " " || name == "" ) return false;
    else return true;
  }
  String dateTimeToString(DateTime _dateTime) {
    String day = _dateTime.day.toString();
    String month = _dateTime.month.toString();
    String year = _dateTime.year.toString();
    return day + "/" + month + "/" + year;
  }

  Widget buttoAccept(BuildContext context) {
    var state = Provider.of<LoginState>(context, listen: false);
    String name = state.getName();
    final database = Provider.of<AppDatabase>(context);
    Alerts alert;
    return Center(
      child: RaisedButton(
        padding: EdgeInsets.all(17.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.indigo,
        child: Text(
          'Aceptar',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        onPressed: () {
          if (_dateTime != null && (nameController.text != "" || name != null)) {
            if(nameController.text != "")context.read<LoginState>().insertarFecha(_dateTime, nameController.text);
            else context.read<LoginState>().insertarFecha(_dateTime);
            context.read<LoginState>().insert(database);
          } else {
            var message;
            if(_dateTime == null && validName(nameController.text)) message = "Introduza su nombre y fecha de nacimiento";
            if(_dateTime == null &&  !validName(nameController.text)) message = "Seleccione su fecha de nacimiento";
            if(_dateTime != null &&  validName(nameController.text)) message = "Introduzca su nombre";
            alert = Alerts(
              context: context,
              firstButtonText: "Ok",
              fun1: () => Navigator.of(context).pop(),
              title: "Alerta",
              message: message,
            );
            alert.showAlertDialog();
            //alert.OneOptionAlert("Ok", context, fun1, "Alerta", "Seleccione su fecha de nacimiento");
          }
        },
      ),
    );
  }

  Widget GotoLogin() {
    return Center(
      child: FlatButton(
        onPressed: () {
          context.read<LoginState>().setFecahIntroducida();
        },
        child: Text(
          "¿Ya estas registrado?",
          style: TextStyle(
            color: Colors.indigo,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _dateBuilder(context));
  }
}
