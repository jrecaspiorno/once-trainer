import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/pideDatos.dart';
import 'dart:developer';
import 'dart:io';

import 'package:googleapis/fitness/v1.dart';

import 'package:fit_kit/fit_kit.dart';
import 'package:health/health.dart';

class MyRitmo extends StatefulWidget {

  @override
  _MyRitmoCardiaco createState() => _MyRitmoCardiaco();
}

class _MyRitmoCardiaco extends  State<MyRitmo>{

  bool exceso = false;
  void initState() {
    super.initState();
    getHealthRate();
  }

  Future<void> getHealthRate() async{
    var _healthKitOutput;
    var _healthDataList = List<HealthDataPoint>();
    bool _isAuthorized = false;

    // Lista de variables
    List<HealthDataType> types = [
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      HealthDataType.HEART_RATE,
      HealthDataType.RESTING_HEART_RATE, // IOS
      HealthDataType.WALKING_HEART_RATE, // IOS

      // IOS, requires Apple Watch
      HealthDataType.HIGH_HEART_RATE_EVENT,
      HealthDataType.LOW_HEART_RATE_EVENT,
      HealthDataType.IRREGULAR_HEART_RATE_EVENT,
    ];

    // Set up dates
    DateTime endDate = DateTime.now();
    //DateTime startDate = endDate.subtract(Duration(seconds: 3));
    DateTime startDate = endDate.subtract(Duration(days: 5)); // TODO: Cambiar a segundos
    //Future.delayed(Duration(seconds: 1), () async{});

    Future.delayed(Duration(seconds: 2), () async {
      _isAuthorized = await Health.requestAuthorization();

      if (_isAuthorized) {
        for (HealthDataType type in types) {
          /// Calls to 'Health.getHealthDataFromType'
          /// must be wrapped in a try catch block.b
          try {
            if (Health.isDataTypeAvailable(type)) {
              List<HealthDataPoint> healthData = await Health
                  .getHealthDataFromType(startDate, endDate, type);
              _healthDataList.addAll(healthData);
              //MyPideDatos(_healthDataList);
              exceso = trataDatos(_healthDataList);
              print(exceso);
              //if(exceso) alert;
            }
            /*
            else{
              //_healthDataList.add(null); // Revisar
              _healthDataList.addAll(Iterable.empty());
            }
            */
          } catch (exception) {
            print(exception.toString());
          }
        }
        setState(() {});
      }
      else {
        print('Not authorized');
      }
    });
    print("fuera");
    return _healthDataList;
  }

  /*
  AlertDialog alert = AlertDialog(
    title: Text("Cuidado!"),
    content: Text("Seguir?"),
    actions: [
      FlatButton(
        child: Text('No'),
        onPressed: () {
          //Navigator.pop(context);
        },
      ),
      FlatButton(
        child: Text('Si'),
        //onPressed: Navigator.of(context).pop,
      ),
    ],
  );
   */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: !exceso
            ? Text("Error")
            : AlertDialog(
          title: Text("Cuidado!"),
          content: Text("Seguir?"),
          actions: [
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Si'),
              //onPressed: Navigator.of(context).pop,
            ),
          ],
          backgroundColor: Colors.indigo,
        ),
      ),
    );
  }
}