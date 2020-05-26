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
      HealthDataType.HEART_RATE,
    ];

    // Set up dates
    DateTime endDate = DateTime.now();
    //DateTime startDate = endDate.subtract(Duration(seconds: 3));
    DateTime startDate = endDate.subtract(Duration(days: 20)); // TODO: Cambiar a segundos
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
          backgroundColor: Colors.indigo,
        ),
        body: !exceso
            ? Text("Error", style: TextStyle(fontSize: 30))
            : AlertDialog(
              title: Text("Alerta!", style: TextStyle(color: Colors.white, fontSize: 30)),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Cuidado tu ritmo cardiaco es muy alto.', style: TextStyle(color: Colors.white, fontSize: 20)),
                    //Text('Estas de acuerdo.', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
              actions: [
                FlatButton(
                  textColor: Colors.white,
                  child: Text('Aceptar', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                /*
                FlatButton(
                  child: Text('Si'),
                  textColor: Colors.white,
                  //onPressed: Navigator.of(context).pop,
                ),
                */
              ],
              backgroundColor: Colors.indigo,
           ),
      ),
    );
  }
}