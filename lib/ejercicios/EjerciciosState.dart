import 'package:flutter/widgets.dart';

import 'Ejercicio.dart';

class EjercicioState with ChangeNotifier{
  Ejercicio _ej;
  String _time;
  int _reps;
  int _series;
  String _tipo;
  void setTipo(String tipo) => this._tipo =tipo;
  void setEjercicio(Ejercicio ejercicio) => this._ej = ejercicio;
  void setTiempo(String time) => this._time = time;
  void setReps(int rep) => this._reps= rep;
  void setSeries(int series) => this._series = series;
  Ejercicio getEjercicio() => this._ej;
  String getTime() => _time;
  int getReps() => _reps;
  int getSeries() => _series;
  String getTipo() => _tipo;

}