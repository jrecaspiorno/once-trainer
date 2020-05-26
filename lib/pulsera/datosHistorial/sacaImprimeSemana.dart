import 'package:flutter/material.dart';
import 'package:flutterapp/pulsera/datosHistorial/tablaDatos.dart';
import 'dart:async';
import 'package:health/health.dart';

import 'package:intl/intl.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'package:translator/translator.dart';

class MySaca extends StatefulWidget{
  String tipoEntrada;

  MySaca(String tipoEntrada){
    this.tipoEntrada = tipoEntrada;
  }
  @override
  _MySacaImprime createState() => _MySacaImprime(tipoEntrada);
}

class _MySacaImprime extends State<MySaca> {
  var _healthKitOutput;
  var _healthDataList = List<HealthDataPoint>();
  bool _isAuthorized = false;
  HealthDataType tipoEntrada;
  String mytipo;
  String mytipoEsp;
  String myunidad;

  List<double> media = [0, 0, 0 ,0 ,0 ,0, 0];
  List<String> quedia = ["", "", "", "", "", "", ""];
  int aux = 0;

  /*
  _MySacaImprime(HealthDataType tipoEntrada){
    this.tipoEntrada = tipoEntrada;
  }*/
  _MySacaImprime(String tipo) {
    mytipo = tipo;
    if (tipo == "WEIGHT") {
      mytipoEsp = "Peso";
      myunidad = "Kilogramos";
      tipoEntrada = HealthDataType.WEIGHT;
    }
    if (tipo == "HEART_RATE") {
      mytipoEsp = "Ritmo cardiaco";
      myunidad = "Pulsaciones por minuto";
      tipoEntrada = HealthDataType.HEART_RATE;
    }
    if (tipo == "ACTIVE_ENERGY_BURNED") {
      mytipoEsp = "Calorias quemada";
      myunidad = "Calorias";
      tipoEntrada = HealthDataType.ACTIVE_ENERGY_BURNED;
    }
    if (tipo == "STEPS"){
      mytipoEsp = "Pasos";
      myunidad = "Pasos";
      tipoEntrada = HealthDataType.STEPS;
    }
  }

  void initState() {
    super.initState();
    initPlatformState();
  }

  List<double> sacaMedia (String tipo, List <HealthDataPoint> _healthDataList) {
    DateTime endDate = DateTime.now();
    //DateTime startDate = endDate.subtract(Duration(days: 6));
    int hacedias = 6;

    // TODO: comprobar el numero de dias que paso (desde sacaImprime)
    HealthDataPoint actual, anterior;
    List<int> cont = [0, 0, 0 ,0 ,0 ,0, 0];
    List<double> suma = [0, 0, 0 ,0 ,0 ,0, 0];
    int dia = 0;
    aux = 0;
    //Iterator it = _healthDataList.iterator;

    if(_healthDataList.isNotEmpty)
      actual = anterior = _healthDataList[0];

    //print(DateFormat('EEEE, d MMM, yyyy').format(startDate));
    quedia[dia] = (DateFormat('EEEE, d MMM, yyyy').format(endDate.subtract(Duration(days: hacedias))));
    //print(quedia[dia]);

    for (int i = 0; i < _healthDataList.length; i++) {
      actual = _healthDataList[i];
      if(DateTime.fromMillisecondsSinceEpoch(anterior.dateFrom).year ==  DateTime.fromMillisecondsSinceEpoch(actual.dateFrom).year &&
          DateTime.fromMillisecondsSinceEpoch(anterior.dateFrom).month ==  DateTime.fromMillisecondsSinceEpoch(actual.dateFrom).month &&
          DateTime.fromMillisecondsSinceEpoch(anterior.dateFrom).day ==  DateTime.fromMillisecondsSinceEpoch(actual.dateFrom).day){
        suma[dia] = suma[dia] + actual.value;
        cont[dia]++;
      }
      else {
        if(suma[dia] != 0)
          aux++;

        dia++;
        //print(dia);
        suma[dia] = actual.value;
        cont[dia] = 1;
        hacedias--;
        quedia[aux] = (DateFormat('EEEE, d MMM, yyyy').format(endDate.subtract(Duration(days: hacedias))));
        //print(quedia[dia]);
      }
      anterior = actual;
    }

    if(suma[dia] != 0)
      aux++;

    //List<double> media = [0, 0, 0 ,0 ,0 ,0, 0];
    if (tipo == "WEIGHT" || tipo == "HEART_RATE") {
      for (int i = 0; i < 7; i++) {
        if(suma[i] != 0 && cont[i] != 0)
          media[i] = (suma[i] / cont[i]); // ~/
      }
    }
    else { // tipo == "ACTIVE_ENERGY_BURNED"
      for (int i = 0; i < 7; i++) {
        media[i] = (suma[i]);
      }
    }
    return media;
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
        /*
        for (var healthData in _healthDataList) {
          print("Data: $healthData");
        }
        */
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
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("${mytipoEsp}"),
          backgroundColor: Colors.indigo,
        ),
        body: _healthDataList.isEmpty
            ? Text("Cargando...", style: TextStyle(fontSize: 25)) // Centrar y mas grande
            //: Semantics (child: TimeSeriesBar.withSampleData(sacaMedia(tipoEntrada.toString(), _healthDataList)), label: "Tabla",),
            : ListView(
                //padding: const EdgeInsets.all(8),
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 500),
                    child: Semantics (child: TimeSeriesBar.withSampleData(sacaMedia(mytipo, _healthDataList)), label: 'Gráfica datos',),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: aux,
                      itemBuilder: (_, index) => ListTile(
                        title: Text("${quedia[index]}"),
                        trailing: (mytipoEsp == "Pasos" || mytipoEsp == "Ritmo cardiaco")
                            ? Text('${media[index].toStringAsFixed(0)} ${myunidad}')
                            : Text('${media[index].toStringAsFixed(2)} ${myunidad}'),
                        //trailing: Text('${media[index].toStringAsFixed(2)} ${_healthDataList[index].unit}'),
                        //subtitle: Text('${tipoEntrada.toString()}: ${media[index].toStringAsFixed(2)}'),
                      )
                  ),
                ],
        )
      ),
    );
  }
}

