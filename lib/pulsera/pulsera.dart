import 'package:flutter/material.dart';
import 'package:fit_kit/fit_kit.dart';

void read() async {
  final results = await FitKit.read(
    DataType.HEART_RATE,
    dateFrom: DateTime.now().subtract(Duration(days: 5)),
    dateTo: DateTime.now(),
  );
}

void readLast() async {
  final result = await FitKit.readLast(DataType.HEIGHT);
}

void readAll() async {
  if (await FitKit.requestPermissions(DataType.values)) {
    for (DataType type in DataType.values) {
      final results = await FitKit.read(
        type,
        dateFrom: DateTime.now().subtract(Duration(days: 5)),
        dateTo: DateTime.now(),
      );
    }
  }
}