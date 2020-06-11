
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:provider/provider.dart';

class BuildHistEntry extends StatelessWidget {
  Historial entry;
  TextStyle t1 = TextStyle(
    color: Colors.indigo,
    fontSize: 20,
  );
  TextStyle t2 = TextStyle(
    color: Colors.black,
    fontSize: 20,
  );

  BuildHistEntry(Historial h) {
    this.entry = h;
  }



  @override
  Widget build(BuildContext context) {
    void quitarejercicio() async{
      final database = Provider.of<AppDatabase>(context ,listen: false);
      database.historialDAO.deleteHistorial(entry);
    }

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
          extendBodyBehindAppBar: false,
          body: Column(children: <Widget>[
            Column(
              children: <Widget>[
                   Text(
                    "Nombre del ejercicio: ",
                    style: t1,
                    textAlign: TextAlign.center,
                  ),

                Text(
                  entry.ejercicio,
                  style: t2,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  "Fecha de realizacion: ",
                  style: t1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  entry.fecha.toString(),
                  style: t2,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  "Estimacion de calorias ",
                  style: t1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  entry.calorias.toString(),
                  style: t2,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  "Dificultad de realizacion: ",
                  style: t1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  entry.dificultad.toString(),
                  style: t2,
                  textAlign: TextAlign.center,
                )
              ],
            ),
      new RaisedButton(
          color:Colors.indigo,
          onPressed: quitarejercicio,
          child: new Text("Borrar Entrada",style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),),
      )]),
        ));
  }
}
