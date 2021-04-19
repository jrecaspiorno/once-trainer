import 'package:flutter/material.dart';
import 'package:flutterapp/pulsera/datosHistorial/tablaDatos.dart';
import 'dart:async';
import 'package:health/health.dart';

import 'package:intl/intl.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'package:translator/translator.dart';

import 'package:flutterapp/ejercicios/AppTimer.dart';
import 'package:flutterapp/ejercicios/AppRepCount.dart';

class MySaca extends StatefulWidget {
  String tipoEntrada;

  MySaca(String tipoEntrada) {
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

  List<double> media = [0, 0, 0, 0, 0, 0, 0];
  List<String> quedia = ["", "", "", "", "", "", ""];
  int aux = 0;

  Timer timer;
  bool estaCargando = true;
  String varImprimir = "Cargando";
  int cont = 0;

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
      mytipoEsp = "Calorías quemadas";
      myunidad = "Calorías";
      tipoEntrada = HealthDataType.ACTIVE_ENERGY_BURNED;
    }
    if (tipo == "STEPS") {
      mytipoEsp = "Pasos";
      myunidad = "Pasos";
      tipoEntrada = HealthDataType.STEPS;
    }
  }

  void initState() {
    super.initState();
    initPlatformState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      // En principio cada 3 seg
      if (_healthDataList.isEmpty) {
        // Si la lista es vacia
        cont++;
        //print(_healthDataList);
        //print(cont);
        if (cont == 10) {
          // Has esperado 10 seg
          varImprimir = "Error al coger los datos";
          setState(() {});
          dispose();
        }
      } else {
        // Si hay algo en la lista
        dispose();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List<double> sacaMedia(String tipo, List<HealthDataPoint> _healthDataList) {
    DateTime endDate = DateTime.now();
    //DateTime startDate = endDate.subtract(Duration(days: 6));
    int hacedias = 6;

    // TODO: comprobar el numero de dias que paso (desde sacaImprime)
    HealthDataPoint actual, anterior;
    List<int> cont = [0, 0, 0, 0, 0, 0, 0];
    List<double> suma = [0, 0, 0, 0, 0, 0, 0];
    int dia = 0;
    aux = 0;
    //Iterator it = _healthDataList.iterator;

    if (_healthDataList.isNotEmpty) actual = anterior = _healthDataList[0];

    //print(DateFormat('EEEE, d MMM, yyyy').format(startDate));
    quedia[dia] = (DateFormat('EEEE, d MMM, yyyy')
        .format(endDate.subtract(Duration(days: hacedias))));
    //print(quedia[dia]);

    for (int i = 0; i < _healthDataList.length; i++) {
      actual = _healthDataList[i];
      if (DateTime.fromMillisecondsSinceEpoch(anterior.dateFrom.year).year ==
              DateTime.fromMillisecondsSinceEpoch(actual.dateFrom.year).year &&
          DateTime.fromMillisecondsSinceEpoch(anterior.dateFrom.month).month ==
              DateTime.fromMillisecondsSinceEpoch(actual.dateFrom.month)
                  .month &&
          DateTime.fromMillisecondsSinceEpoch(anterior.dateFrom.day).day ==
              DateTime.fromMillisecondsSinceEpoch(actual.dateFrom.day).day) {
        suma[dia] = suma[dia] + actual.value;
        cont[dia]++;
      } else {
        if (suma[dia] != 0) aux++;

        dia++;
        //print(dia);
        suma[dia] = actual.value;
        cont[dia] = 1;
        hacedias--;
        quedia[aux] = (DateFormat('EEEE, d MMM, yyyy')
            .format(endDate.subtract(Duration(days: hacedias))));
        //print(quedia[dia]);
      }
      anterior = actual;
    }

    if (suma[dia] != 0) aux++;

    //List<double> media = [0, 0, 0 ,0 ,0 ,0, 0];
    if (tipo == "WEIGHT" || tipo == "HEART_RATE") {
      for (int i = 0; i < 7; i++) {
        if (suma[i] != 0 && cont[i] != 0) media[i] = (suma[i] / cont[i]); // ~/
      }
    } else {
      // tipo == "ACTIVE_ENERGY_BURNED"
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

    print(endDate.millisecondsSinceEpoch);
    print(endDate);
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

        try {
          List<HealthDataPoint> healthData = await Health.getHealthDataFromType(
              startDate, endDate, tipoEntrada);

          // Sacar media y añadir solo eso
          _healthDataList.addAll(healthData);
        } catch (exception) {
          print(exception.toString());
        }
        //}
        //*
        for (var healthData in _healthDataList) {
          print("Data: $healthData");
        }
        //*/

        //TimeSeriesBar.withSampleData(tipoEntrada.toString(), _healthDataList);
        setState(() {});
        //var seriesList = TimeSeriesBar.withSampleData(tipoEntrada.toString(), _healthDataList);
      } else {
        print('Not authorized');
      }
      //print("hola desde dentro");
      //print(_healthDataList);

      return _healthDataList;
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      throw ('Timeout');
    });

    //print("hola desde fuera");
    //print(_healthDataList);
  }

  String translateDates(String data) {
    var splitted = data.split(",");
    var aux = splitted[1].split(" ");

    var diaSemana;
    var mesEsp;
    var mesIng = aux[2];
    var nDia = aux[1];
    var anio = splitted[2];
    switch (splitted[0]) {
      case "Thursday":
        diaSemana = "Jueves ";
        break;
      case "Friday":
        diaSemana = "Viernes ";
        break;
      case "Saturday":
        diaSemana = "Sabado ";
        break;
      case "Sunday":
        diaSemana = "Domingo ";
        break;
      case "Monday":
        diaSemana = "Lunes ";
        break;
      case "Tuesday":
        diaSemana = "Martes ";
        break;
      case "Wednesday":
        diaSemana = "Míercoles ";
        break;
    }
    switch (mesIng) {
      case "Apr":
        mesEsp = "Abril ";
        break;
      case "May":
        mesEsp = "Mayo ";
        break;
      case "Jul":
        mesEsp = "Julio ";
        break;
      case "July":
        mesEsp = "Julio ";
        break;
      case "Jun":
        mesEsp = "Junio ";
        break;
      case "June":
        mesEsp = "Junio ";
        break;
      case "Aug":
        mesEsp = "Agosto ";
        break;
      case "Sep":
        mesEsp = "Septiembre ";
        break;
      case "Sept":
        mesEsp = "Septiembre ";
        break;
      case "Oct":
        mesEsp = "Octubre ";
        break;
      case "Nov":
        mesEsp = "Noviembre ";
        break;
      case "Dec":
        mesEsp = "Diciembre ";
        break;
      case "Jan":
        mesEsp = "Enero ";
        break;
      case "Feb":
        mesEsp = "Febrero ";
        break;
      case "Mar":
        mesEsp = "Marzo ";
        break;

    }

    return diaSemana + nDia + " de " + mesEsp + "del" + anio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ? Center(
              child: Text(varImprimir,
                  style: TextStyle(fontSize: 40))) // Centrar y mas grande
          //: Semantics (child: TimeSeriesBar.withSampleData(sacaMedia(tipoEntrada.toString(), _healthDataList)), label: "Tabla",),
          : ListView(
              //padding: const EdgeInsets.all(8),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 500),
                    child: Semantics(
                      child: TimeSeriesBar.withSampleData(
                          sacaMedia(mytipo, _healthDataList)),
                      label: 'Gráfica con los datos',
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: aux,
                    itemBuilder: (_, index) => ListTile(
                          title: Text(translateDates(quedia[index])),
                          trailing: (mytipoEsp == "Pasos" ||
                                  mytipoEsp == "Ritmo cardiaco")
                              ? Text(
                                  '${media[index].toStringAsFixed(0)} ${myunidad}')
                              : Text(
                                  '${media[index].toStringAsFixed(2)} ${myunidad}'),
                          //trailing: Text('${media[index].toStringAsFixed(2)} ${_healthDataList[index].unit}'),
                          //subtitle: Text('${tipoEntrada.toString()}: ${media[index].toStringAsFixed(2)}'),
                        )),
              ],
            ),
    );
  }
}
