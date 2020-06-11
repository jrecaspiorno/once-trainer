import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/pideDatos.dart';
import 'dart:developer';
import 'dart:io';

import 'package:googleapis/fitness/v1.dart';

import 'package:fit_kit/fit_kit.dart';
import 'package:health/health.dart';

import 'package:flutterapp/Data/moor_database.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/Registro/SignUpState.dart';

  bool getHealthRate(int edad) {
    var _healthKitOutput;
    var _healthDataList = List<HealthDataPoint>();
    bool _isAuthorized = false;
    bool exceso = false;

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

              exceso = trataDatos(_healthDataList, edad);
              print(exceso);
              //if(exceso) alert;
            }
          } catch (exception) {
            print(exception.toString());
          }
        }
        //setState(() {});
      }
      else {
        print('Not authorized');
      }
    });
    print("fuera");
    return exceso;
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

//}