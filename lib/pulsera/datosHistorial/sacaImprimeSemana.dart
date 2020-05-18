import 'package:flutter/material.dart';
import 'package:flutterapp/pulsera/datosHistorial/tablaDatos.dart';
import 'dart:async';
import 'package:health/health.dart';

class MySaca extends StatefulWidget{
  HealthDataType tipoEntrada;

  MySaca(String tipo) {
    if (tipo == "WEIGHT")
      tipoEntrada = HealthDataType.WEIGHT;
    if (tipo == "HEART_RATE")
      tipoEntrada = HealthDataType.HEART_RATE;
    if (tipo == "ACTIVE_ENERGY_BURNED")
      tipoEntrada = HealthDataType.ACTIVE_ENERGY_BURNED;
    if (tipo == "STEPS")
      tipoEntrada = HealthDataType.STEPS;
  }
  @override
  _MySacaImprime createState() => _MySacaImprime(tipoEntrada);
}

class _MySacaImprime extends State<MySaca> {
  var _healthKitOutput;
  var _healthDataList = List<HealthDataPoint>();
  bool _isAuthorized = false;
  HealthDataType tipoEntrada;
  _MySacaImprime(HealthDataType tipoEntrada){
    this.tipoEntrada = tipoEntrada;
  }

  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(days: 6));

    //print("hola");
    Future.delayed(Duration(seconds: 2), () async {
      _isAuthorized = await Health.requestAuthorization();

      if (_isAuthorized) {

        // Lista de variables
        List<HealthDataType> types = [
          HealthDataType.WEIGHT,
          HealthDataType.HEART_RATE,
          HealthDataType.ACTIVE_ENERGY_BURNED,
          HealthDataType.STEPS,
        ];

        //for (tipoEntrada in types) {
        /// Calls to 'Health.getHealthDataFromType'
        /// must be wrapped in a try catch block.b
        try {
          List<HealthDataPoint> healthData = await Health
              .getHealthDataFromType(startDate, endDate, tipoEntrada);

          // Sacar media y añadir solo eso
          _healthDataList.addAll(healthData);

        } catch (exception) {
          print(exception.toString());
        }
        //}

        for (var healthData in _healthDataList) {
          print("Data: $healthData");
        }
        /// Update the UI to display the results
        //TimeSeriesBar.withSampleData(tipoEntrada.toString(), _healthDataList);
        setState(() {});
        //var seriesList = TimeSeriesBar.withSampleData(tipoEntrada.toString(), _healthDataList);
      }
      else {
        print('Not authorized');
      }
      //print("hola desde dentro");
      //print(_healthDataList);

      return _healthDataList;
    }).timeout(const Duration (seconds: 10), onTimeout: (){
      throw('Timeout');
    });

    //print("hola desde fuera");
    //print(_healthDataList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: _healthDataList.isEmpty
            ? Text("Cargando...", style: TextStyle(fontSize: 25)) // Centrar y mas grande
            : Semantics (child: TimeSeriesBar.withSampleData(tipoEntrada.toString(), _healthDataList), label: "Tabla",),
      ),
    );
  }
}