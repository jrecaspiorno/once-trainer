import 'dart:io';

/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutterapp/pulsera/sacaDatosSemana.dart';
import 'package:health/health.dart';

class TimeSeriesBar extends StatelessWidget {
  List<charts.Series<TimeSeriesSales, DateTime>> seriesList = [];
  final bool animate;

  TimeSeriesBar(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory TimeSeriesBar.withSampleData(String tipo) {
    return new TimeSeriesBar(
      _createSampleData(tipo),
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
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(String tipo) {
    List<HealthDataPoint> _healthDataList = MySacaDatosSemana(tipo);
    //sleep(Duration (seconds: 2));
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(days: 7));

    HealthDataPoint actual, anterior;
    List<int> cont = [0, 0, 0 ,0 ,0 ,0, 0];
    List<int> suma = [0, 0, 0 ,0 ,0 ,0, 0];
    int dia = 1;
    //Iterator it = _healthDataList.iterator;

    print(_healthDataList);
    for (int i = 0; i < _healthDataList.length; i++) {
      actual = _healthDataList[i];
      if (anterior.dateFrom == actual.dateFrom &&
          anterior.dateTo == actual.dateTo) {
        suma[dia] = suma[dia] + actual.value;
        cont[dia]++;
      }
      else {
        dia++;
        suma[dia] = actual.value;
        cont[dia] = 1;
      }
      anterior = actual;
    }

    List<int> media;
    if (tipo == "WEIGHT" || tipo == "HEART_RATE") {
      for (int i = 1; i < 8; i++) {
        media[i] = (suma[i] ~/ cont[i]);
      }
    }
    else { // tipo == "ACTIVE_ENERGY_BURNED"
      for (int i = 1; i < 8; i++) {
        media[i] = (suma[i]);
      }
    }

    final data = [
      new TimeSeriesSales(endDate.subtract(Duration(days: 7)), media[1]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 6)), media[2]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 5)), media[3]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 4)), media[4]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 3)), media[5]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 2)), media[6]),
      new TimeSeriesSales(endDate.subtract(Duration(days: 1)), media[7]),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
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
  final int value;

  TimeSeriesSales(this.date, this.value);
}