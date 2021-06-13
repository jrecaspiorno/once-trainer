import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;

import '../pulsera/datosHistorial/tablaDatos.dart';

class MyHistorial extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: _navigationService.goBack,
        ),
        title: Text("Historial Clínico"),
        backgroundColor: Colors.deepPurple,
      ),
      body: MenuView(context),
    );
  }

  List<charts.Series<TimeSeriesSales, DateTime>> SacaDatos() {
    List<charts.Series<TimeSeriesSales, DateTime>> data = [];
    return data;
  }

  Widget MenuView(BuildContext context) {
    return Center(
      child: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildButton('Peso', "WEIGHT"),
          _buildButton('Ritmo Cardiaco', "HEART_RATE"),
          _buildButton('Energía Quemada', "ACTIVE_ENERGY_BURNED"),
        ],
      )),
    );
  }

  Column _buildButton(String label, String tipo) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 300,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () => _navigationService.navigateTo(route.SacaDatosPage,
                arguments: tipo),
            color: Colors.deepPurple,
            textColor: Colors.white,
            padding: EdgeInsets.all(24.0),
            child: Text(label, style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
