import 'package:flutter/material.dart';
import 'dart:async';
import 'package:health/health.dart';

class MySacaImprime extends StatelessWidget {
  var _healthKitOutput;
  var _healthDataList = List<HealthDataPoint>();
  bool _isAuthorized = false;
  HealthDataType tipoEntrada;

  MySacaImprime(String tipo){
    if(tipo == "WEIGHT")
      tipoEntrada = HealthDataType.WEIGHT;
    if(tipo == "HEART_RATE")
      tipoEntrada = HealthDataType.HEART_RATE;
    if(tipo == "ACTIVE_ENERGY_BURNED")
      tipoEntrada = HealthDataType.ACTIVE_ENERGY_BURNED;
  }

  void initState() {
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(days: 7));

    print("hola");
    Future.delayed(Duration(seconds: 2), () async {
      _isAuthorized = await Health.requestAuthorization();

      if (_isAuthorized) {

        // Lista de variables
        List<HealthDataType> types = [
          HealthDataType.WEIGHT,
          HealthDataType.HEART_RATE,
          HealthDataType.ACTIVE_ENERGY_BURNED,
        ];

        //for (tipoEntrada in types) {
        /// Calls to 'Health.getHealthDataFromType'
        /// must be wrapped in a try catch block.b
        try {
          List<HealthDataPoint> healthData = await Health
              .getHealthDataFromType(startDate, endDate, tipoEntrada);
          _healthDataList.addAll(healthData);

        } catch (exception) {
          print(exception.toString());
        }
        //}

        for (var healthData in _healthDataList) {
          print("Data: $healthData");
        }
      }
      else {
        print('Not authorized');
      }
      print("hola desde dentro");
      print(_healthDataList);

      return _healthDataList;
    }).timeout(const Duration (seconds: 5), onTimeout: (){
      throw('Timeout');
    });

    print("hola desde fuera");
    print(_healthDataList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: _healthDataList.isEmpty
            ? Text('$_healthKitOutput\n')
            : ListView.builder(
            itemCount: _healthDataList.length,
            itemBuilder: (_, index) => ListTile(
              title: Text(
                  "${_healthDataList[index].dataType.toString()}: ${_healthDataList[index].value.toString()}"),
              trailing: Text('${_healthDataList[index].unit}'),
              subtitle: Text(
                  '${DateTime.fromMillisecondsSinceEpoch(_healthDataList[index].dateFrom)} - ${DateTime.fromMillisecondsSinceEpoch(_healthDataList[index].dateTo)}'),
            )),
      ),
    );
  }
}