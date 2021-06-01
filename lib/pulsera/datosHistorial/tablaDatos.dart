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


  factory TimeSeriesBar.withSampleData(List <double> media) {
    return new TimeSeriesBar(
      _createSampleData(media),
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,

      defaultRenderer: new charts.BarRendererConfig<DateTime>(),

      defaultInteractions: false,

      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
    );
  }


  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(List<double> media) {

    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(days: 6));

    final data = [
       TimeSeriesSales(endDate.subtract(Duration(days: 6)), media[0]),
       TimeSeriesSales(endDate.subtract(Duration(days: 5)), media[1]),
       TimeSeriesSales(endDate.subtract(Duration(days: 4)), media[2]),
       TimeSeriesSales(endDate.subtract(Duration(days: 3)), media[3]),
       TimeSeriesSales(endDate.subtract(Duration(days: 2)), media[4]),
       TimeSeriesSales(endDate.subtract(Duration(days: 1)), media[5]),
       TimeSeriesSales(endDate.subtract(Duration(days: 0)), media[6]),
    ];

    return [
      charts.Series<TimeSeriesSales, DateTime>(
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