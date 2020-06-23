import 'package:flutter/widgets.dart';

import 'Ejercicio.dart';

class EjercicioState with ChangeNotifier{
  Ejercicio _ej;
  String _time;
  int _reps;
  int _series;
  String _tipo;
  int _diff;
  int stringtoTime(String h) {
    return ((int.parse(h[0]) * 10) + (int.parse(h[1])) * 60) +
        (int.parse(h[3]) * 10) +
        (int.parse(h[4]));
  }
  String timetoString(int t) {
    int min = t ~/ 60;
    int sec = t % 60;
    if(sec%10 != 0) {
      sec.round();
      if(sec >= 60) {
        sec -=60;
        min +=1;
      }
    }
    String secs = sec.toString().padLeft(2, "0");
    String mins = min.toString().padLeft(2, "0");
    return (mins +":" +secs);
  }
  void setTipo(String tipo) => this._tipo =tipo;
  void setEjercicio(Ejercicio ejercicio) => this._ej = ejercicio;
  void setTiempo(String time){
    int t = stringtoTime(time);
    String ti;
    if(_ej.dificultad == 0)
      this._time= time;
    else if (_ej.dificultad == -1){
      t = (t * 0.7).round();
      ti = timetoString(t);
      this._time = ti;
    }
      
    else if (_ej.dificultad == 1){
      t = (t * 1.3).round();
      ti = timetoString(t);
      this._time = ti;
    }
    
  }
  void setReps(int rep) {
    if(_ej.dificultad == 0)
      this._reps= rep;
    else if (_ej.dificultad == -1)
      this._reps = (rep * 0.7).round();
    else if (_ej.dificultad == 1){
      this._reps = (rep * 1.3).round();
    }
  }
  void setSeries(int series) => this._series = series;
<<<<<<< HEAD
  set dif(int _dif) =>  _diff = _dif;
  get diff => _diff;
  get getTime => _time;
  get getReps => _reps;
  get getSeries => _series;
  get getTipo => _tipo;
  get ejercicio => _ej;

=======
  Ejercicio getEjercicio() => this._ej;
  String getTime() => _time;
  int getReps() => _reps;
  int getSeries() => _series;
  String getTipo() => _tipo;
>>>>>>> 576c48aeb249c60b0baaa11beacc3d5dc98b2261

}