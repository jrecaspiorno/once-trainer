import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/alertaRitmo.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/pideDatos.dart';
import 'dart:developer';
import 'dart:io';

import 'package:googleapis/fitness/v1.dart';

import 'package:fit_kit/fit_kit.dart';
import 'package:health/health.dart';

import 'package:flutterapp/Data/moor_database.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/Provider/MyProvider.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/alertaRitmo.dart';

bool AuxExceso = false;
void setAuxExceso(bool aux){
  AuxExceso = aux;
}

bool getAuxExceso(){
  return AuxExceso;
}

  void getHealthRate(int edad, BuildContext context) {

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
    DateTime startDate = endDate.subtract(
        //Duration(seconds: 3));
        Duration(days: 300)); // TODO: Cambiar a segundos
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
              //final database = Provider.of<AppDatabase>(context, listen: false);

             /* var state = context.read<LoginState>();
              String id = state.getId();
              var user = await database.usuarioDAO.getUser(id);
              var fecha_n = user.edad.year; // En teoria pasamos solo el año
              //print(fecha_n);
              var edad = endDate.year - fecha_n;*/
              // exceso = trataDatos(_healthDataList, edad);
              exceso = trataDatos(_healthDataList, edad);
              //print(exceso);
              //if(exceso) alert;
              if (exceso && !getAuxExceso()) {
              // MyAlerta();
                setAuxExceso(exceso);
                _showAlert(context);
              }
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
    //print("fuera");
    //return exceso;
  }

void _showAlert(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => MyAlerta()
  );
}
/*void waitExceso(){
   //final myProvider = Provider.of<MyProvider>(context);
   if(myProvider.exceso){
     MyAlerta();
   }
 }*/


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