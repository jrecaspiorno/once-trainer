import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
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
    return Scaffold(
        body: Center(
  
              child: Consumer<LoginState>(
                  builder: (BuildContext context, LoginState value, Widget child){
                    if(value.isLoading()){
                        return CircularProgressIndicator();
                    }else{
                      return child;
                    }
                  },
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
    
                      ButtoAccept(context),
    
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

  Widget DateSel(){
      return Center(
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),

          color: Colors.indigo,
          padding: EdgeInsets.all(13.0),
          
          autofocus: true,
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
          fontSize: 30,
          color: Colors.indigo
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  String DateTimeToString(DateTime _dateTime){
    String day = _dateTime.day.toString();
    String month = _dateTime.month.toString();
    String year = _dateTime.year.toString();
    return day + "/" + month + "/" + year;
  }

  Widget ButtoAccept(BuildContext context){
    final database = Provider.of<AppDatabase>(context); 
    Alerts alert;
    return Center(
      child: RaisedButton(
        padding: EdgeInsets.all(17.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.indigo,
        child: Text(
          'Aceptar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30
          ),
        ),
        onPressed: (){
          if(_dateTime != null){
            context.read<LoginState>().insertarFecha(_dateTime);
            context.read<LoginState>().insert(database);
          }
          else{
            alert = Alerts(context: context, firstButtonText: "Ok", fun1:() => Navigator.of(context).pop() , title: "Alerta", message: "Seleccione su fecha de nacimiento",);
            alert.showAlertDialog();
            //alert.OneOptionAlert("Ok", context, fun1, "Alerta", "Seleccione su fecha de nacimiento");
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
        
        body: _DateBuilder(context));
  }
}
