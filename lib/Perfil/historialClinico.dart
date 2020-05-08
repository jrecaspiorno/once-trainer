import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Perfil/Perfil.dart';
import 'package:flutterapp/pulsera/sacaDatosSemana.dart';
import 'package:health/health.dart';

import '../lista_ejer.dart';
import '../recomendados.dart';
import '../pulsera/tablaDatos.dart';

import 'package:charts_flutter/flutter.dart' as charts;



class MyHistorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Historial Clinico"),
          backgroundColor: Colors.indigo,
        ),
        body: MenuView(context),
      ),
    );
  }

  List<charts.Series<TimeSeriesSales, DateTime>> SacaDatos(){
    //List<HealthDataPoint> aux = MySacaDatosSemana(tipo);
    List<charts.Series<TimeSeriesSales, DateTime>> data = [];
    return data;
  }

  Widget MenuView(BuildContext context) {
    return Center(
      child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildButton('Peso', "WEIGHT", context),
              _buildButton('Ritmo Cardiaco', "HEART_RATE", context),
              _buildButton('Energia Quemada', "ACTIVE_ENERGY_BURNED", context),
            ],
          )),
    );
  }

  Column _buildButton(String label, String tipo, BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TimeSeriesBar.withSampleData(tipo)),
            );
          },
          color: Colors.indigo,
          textColor: Colors.white,
          padding: EdgeInsets.all(24.0),
          child: Text(label, style: TextStyle(fontSize: 30)),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
