import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/chat/v1.dart';
import 'package:provider/provider.dart';
import '../SignUpState.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _dateTime;

  Widget _DateBuilder(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        
        children: <Widget>[


          DateSel(),
          Padding(
            padding: EdgeInsets.all(15),
          ),
          ActualSelDate(),
          Padding(
            padding: EdgeInsets.all(15),
          ),
          ButtoAccept(),
          Padding(
            padding: EdgeInsets.all(15),
          ),
          GotoLogin()
        ],

      ),
    );
  }

  Widget DateSel(){
      return Center(
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.indigo,
          child: Text(
            'Introduzca su fecha de nacimiento',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            showDatePicker(
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

  Widget ActualSelDate(){
    return Center(
      child: Text(_dateTime == null ? 'Todavía no has eligido fecha' : DateTimeToString(_dateTime),
        style: TextStyle(
          fontSize: 20
      ),),
    );
  }

  String DateTimeToString(DateTime _dateTime){
    String day = _dateTime.day.toString();
    String month = _dateTime.month.toString();
    String year = _dateTime.year.toString();
    return day + "/" + month + "/" + year;
  }

  Widget ButtoAccept(){
    return Center(
      child: RaisedButton(

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.indigo,
        child: Text(
          'Aceptar',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: (){
          if(_dateTime != null)
            context.read<LoginState>().insertarFecha(_dateTime);
          else{

          }
        },
      ),
    );
  }

  Widget GotoLogin(){
    return Center(
      child: FlatButton(
        onPressed: (){
           context.read<LoginState>().setFecahIntroducida();
        }, 
        child: Text( "¿Ya estas registrado?",
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

    return Scaffold(
        appBar: AppBar(
          title: Text("Fecha"),
          backgroundColor: Colors.indigo,
        ),
        body: _DateBuilder(context));
  }
}
