import 'package:flutterapp/ejercicios/Ejercicio.dart';

class EjercicioTiempo extends Ejercicio{
  String _time;

  EjercicioTiempo(String name, String description, int calories, List<String> tags, String time, int diff, String grupoprincipal ):
        this._time = time,
        super(name, description, calories, tags, diff, grupoprincipal);
    get time => this._time;
    void setTime(String time) => _time = time;
}
