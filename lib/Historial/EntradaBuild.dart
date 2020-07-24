import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';

class BuildHistEntry extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  String parsedificultad(int d) {
    switch (d) {
      case -1:
        return "Fácil";
      case 0:
        return "Normal";
      case 1:
        return "Difícil";
    }
  }

  Widget dato(String texto, String dato) {
    return Column(
      children: <Widget>[
        Text(
          texto,
          style: t1,
          textAlign: TextAlign.center,
        ),
        padd1(),
        Text(
          dato,
          style: t2,
          textAlign: TextAlign.center,
        )
      ],
    );
  }

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
  BuildHistEntry({@required this.dao, @required this.entry});

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
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: _navigationService.goBack,
        ),
        title: Text(entry.ejercicio),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child:
            ListView(padding: EdgeInsets.all(10), shrinkWrap: true, children: <
                Widget>[
          dato("Nombre del ejercicio", entry.ejercicio),
          padd2(),
          dato("Fecha de realización", dateTimeToString(entry.fecha)),
          padd2(),
          dato("Estimación de calorías", entry.calorias.toString()),
          padd2(),
          dato("Dificultad de realización", parsedificultad(entry.dificultad)),
          padd2(),
          (() {
            Column r;
            if (entry.tipo == "tiempo") {
              r = dato("Tiempo del ejercicio", entry.duracion);
            } else {
              r = Column(
                children: <Widget>[
                  dato("Repeticiones del ejercicio",
                      entry.repeticiones.toString()),
                  //padd2(),
                  dato("Series realizadas", entry.series.toString()),
                ],
              );
            }
            return r;
          }()),
          Padding(
            padding: EdgeInsets.all(15),
          ),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.pink,
            onPressed: () {
              dao.deleteHistorial(entry);
              _navigationService.goBack();
            },
            padding: EdgeInsets.all(12.0),
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
    );
  }
}
