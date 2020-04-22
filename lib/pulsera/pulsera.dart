import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';

import 'package:fit_kit/fit_kit.dart';
import 'package:health/health.dart';

class MyPulsera extends StatelessWidget {
  var _healthKitOutput;
  var _healthDataList = List<HealthDataPoint>();
  bool _isAuthorized = false;

  @override
  void initState() {
    _getHealthDataPoints();
  }

  void _getHealthDataPoints() async {
    // Lista de variables
    List<HealthDataType> types = [
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      HealthDataType.STEPS,
      HealthDataType.BODY_MASS_INDEX,
      HealthDataType.WAIST_CIRCUMFERENCE, // IOS
      HealthDataType.BODY_FAT_PERCENTAGE,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.BASAL_ENERGY_BURNED, // IOS
      HealthDataType.HEART_RATE,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.RESTING_HEART_RATE, // IOS
      HealthDataType.WALKING_HEART_RATE, // IOS
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.BLOOD_OXYGEN,

      // IOS, requires Apple Watch
      HealthDataType.ELECTRODERMAL_ACTIVITY,
      HealthDataType.HIGH_HEART_RATE_EVENT,
      HealthDataType.LOW_HEART_RATE_EVENT,
      HealthDataType.IRREGULAR_HEART_RATE_EVENT,
    ];

    DateTime startDate = DateTime.utc(2001, 01, 01);
    DateTime endDate = DateTime.now();

    List<HealthDataPoint> healthDataList = List<HealthDataPoint>();

    Future.delayed(Duration(seconds: 2), () async {
      _isAuthorized = await Health.requestAuthorization();

      // Pruebas
      types.add(HealthDataType.WEIGHT);
      types.insert(180, HealthDataType.WEIGHT);
      bool weightAvailable = Health.isDataTypeAvailable(HealthDataType.WEIGHT);
      debugPrint(weightAvailable.toString());


      if (_isAuthorized) {
        for (HealthDataType type in types) {
          /// Calls to 'Health.getHealthDataFromType'
          /// must be wrapped in a try catch block.b
          try {
            if (Health.isDataTypeAvailable(type)) {
              List<HealthDataPoint> healthData = await Health
                  .getHealthDataFromType(startDate, endDate, type);
              _healthDataList.addAll(healthData);
            }
            else {
              print("Data $type is not compatible");
            }
          } catch (exception) {
            print(exception.toString());
          }
        }

        for (var healthData in healthDataList) {
          print("Data: $healthData");
        }
      }
      else {
        print('Not authorized');
      }
    });
  }

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
            title: Text('Prueba pulsera'),
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
        )
    );
  }
}
