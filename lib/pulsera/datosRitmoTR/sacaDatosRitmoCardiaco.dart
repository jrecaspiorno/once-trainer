import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/pideDatos.dart';
import 'dart:developer';
import 'dart:io';

import 'package:googleapis/fitness/v1.dart';

import 'package:fit_kit/fit_kit.dart';
import 'package:health/health.dart';

List<HealthDataPoint> getHealthRate() {

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
    DateTime startDate = endDate.subtract(Duration(seconds: 3));
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
      }
      else {
        print('Not authorized');
      }
    });
    return _healthDataList;
  }
