import 'dart:io';

/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutterapp/pulsera/datosHistorial/sacaDatosSemana.dart';

import 'package:health/health.dart';

class TimeSeriesBar extends StatelessWidget {
  List<charts.Series<TimeSeriesSales, DateTime>> seriesList = [];
  final bool animate;

  TimeSeriesBar(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory TimeSeriesBar.withSampleData(String tipo, List <HealthDataPoint> _healthDataList) {
    return new TimeSeriesBar(
      _createSampleData(tipo, _healthDataList),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      // It is recommended that default interactions be turned off if using bar
      // renderer, because the line point highlighter is the default for time
      // series chart.
      defaultInteractions: false,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar charts.
      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(String tipo, List <HealthDataPoint> _healthDataList) {

    bool dateAux (HealthDataPoint actual, HealthDataPoint anterior){
      return(DateTime.fromMillisecondsSinceEpoch(anterior.dateFrom).year ==  DateTime.fromMillisecondsSinceEpoch(actual.dateFrom).year &&
          DateTime.fromMillisecondsSinceEpoch(anterior.dateFrom).month ==  DateTime.fromMillisecondsSinceEpoch(actual.dateFrom).month &&
          DateTime.fromMillisecondsSinceEpoch(anterior.dateFrom).day ==  DateTime.fromMillisecondsSinceEpoch(actual.dateFrom).day);
      /*
          && DateTime.fromMillisecondsSinceEpoch(anterior.dateTo).year ==  DateTime.fromMillisecondsSinceEpoch(actual.dateTo).year &&
          DateTime.fromMillisecondsSinceEpoch(anterior.dateTo).month ==  DateTime.fromMillisecondsSinceEpoch(actual.dateTo).month &&
          DateTime.fromMillisecondsSinceEpoch(anterior.dateTo).day ==  DateTime.fromMillisecondsSinceEpoch(actual.dateTo).day
       */
    }
    /*
    List <HealthDataPoint> _healthDataList;
    Future.delayed(Duration(seconds: 1), () async {
      _healthDataList = await MySacaDatosSemana(tipo);
    }).timeout(const Duration (seconds: 5), onTimeout: (){
      throw('Timeout');
    });
    */
    //sleep(Duration (seconds: 2));
    //print(_healthDataList);
    //print("desde funcion tablas");
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(days: 6));

    // TODO: comprobar el numero de dias que paso (desde sacaImprime)
    HealthDataPoint actual, anterior;
    List<int> cont = [0, 0, 0 ,0 ,0 ,0, 0];
    List<double> suma = [0, 0, 0 ,0 ,0 ,0, 0];
    int dia = 0;
    //Iterator it = _healthDataList.iterator;

    if(_healthDataList.isNotEmpty)
        actual = anterior = _healthDataList[0];

    //print(dateAux(actual, anterior));
    // Hasta aqui bien
    for (int i = 0; i < _healthDataList.length; i++) {
      actual = _healthDataList[i];
      //if (anterior.dateFrom == actual.dateFrom &&
      //    anterior.dateTo == actual.dateTo) {
      if(dateAux(actual, anterior)){
        suma[dia] = suma[dia] + actual.value;
        cont[dia]++;
      }
      else {
        //print(dateAux(actual, anterior));
        print("anterior");
        print(DateTime.fromMillisecondsSinceEpoch(anterior.dateFrom));
        //print(DateTime.fromMillisecondsSinceEpoch(anterior.dateTo));
        print("actual");
        print(DateTime.fromMillisecondsSinceEpoch(actual.dateFrom));
        //print(DateTime.fromMillisecondsSinceEpoch(actual.dateTo));
        dia++;
        print(dia);
        suma[dia] = actual.value;
        cont[dia] = 1;
      }
      anterior = actual;
    }
    print("suma: ");
    print(suma);

    List<double> media = [0, 0, 0 ,0 ,0 ,0, 0];
    if (tipo == "WEIGHT" || tipo == "HEART_RATE") {
      for (int i = 0; i < 7; i++) {
        media[i] = (suma[i] / cont[i]); // ~/
      }
    }
    else { // tipo == "ACTIVE_ENERGY_BURNED"
      for (int i = 0; i < 7; i++) {
        media[i] = (suma[i]);
      }
    }

    final data = [
      new TimeSeriesSales(endDate.subtract(Duration(days: 6)), media[6]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 5)), media[5]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 4)), media[4]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 3)), media[3]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 2)), media[2]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 1)), media[1]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 0)), media[0]),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.date,
        measureFn: (TimeSeriesSales sales, _) => sales.value,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime date;
  final double value;

  TimeSeriesSales(this.date, this.value);
}