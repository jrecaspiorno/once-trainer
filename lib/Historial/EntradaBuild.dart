import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:provider/provider.dart';

import 'HistorialBuild.dart';

class BuildHistEntry extends StatelessWidget {



  Historial entry;
  HistorialDAO dao;
  TextStyle t1 = TextStyle(
    color: Colors.indigo,
    fontSize: 30,
  );
  TextStyle t2 = TextStyle(
    color: Colors.black,
    fontSize: 30,
  );
  BuildHistEntry({@required this.dao,@required this.entry});
  

  Widget padd1() {
    return Padding(
      padding: EdgeInsets.all(4),
    );
  }

  Widget padd2() {
    return Padding(
      padding: EdgeInsets.all(10),
    );
  }

  String dateTimeToString(DateTime _dateTime) {
    String day = _dateTime.day.toString();
    String month = _dateTime.month.toString();
    String year = _dateTime.year.toString();
    String hour = _dateTime.hour.toString();
    String min = _dateTime.minute.toString();
    String text = " a las ";
    if (int.parse(min) < 10) min = "0" + min;
    if (hour == "01" || hour == "1") text = " a la ";
    return day + "/" + month + "/" + year + text + hour + ":" + min;
  }

  @override
  Widget build(BuildContext context) {
    
  

    return MaterialApp(
        title: entry.ejercicio,
        home: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(entry.ejercicio),
            backgroundColor: Colors.indigo,
          ),
          body: Center(
            child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.vertical,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Nombre del ejercicio: ",
                        style: t1,
                        textAlign: TextAlign.center,
                      ),
                      padd1(),
                      Text(
                        entry.ejercicio,
                        style: t2,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  padd2(),
                  Column(
                    children: <Widget>[
                      Text(
                        "Fecha de realizacion: ",
                        style: t1,
                        textAlign: TextAlign.center,
                      ),
                      padd1(),
                      Text(
                        dateTimeToString(entry.fecha),
                        style: t2,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  padd2(),
                  Column(
                    children: <Widget>[
                      Text(
                        "Estimacion de calorias ",
                        style: t1,
                        textAlign: TextAlign.center,
                      ),
                      padd1(),
                      Text(
                        entry.calorias.toString(),
                        style: t2,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  padd2(),
                  Column(
                    children: <Widget>[
                      Text(
                        "Dificultad de realizacion: ",
                        style: t1,
                        textAlign: TextAlign.center,
                      ),
                      padd1(),
                      Text(
                        entry.dificultad.toString(),
                        style: t2,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(24),),
                  RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color: Colors.indigo,
                    onPressed: (){
                      dao.deleteHistorial(entry);
                      Navigator.push(context,MaterialPageRoute(builder: (context) => MyHistory()));

                    },
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Borrar Entrada",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ]),
          ),
        ));
  }
}
