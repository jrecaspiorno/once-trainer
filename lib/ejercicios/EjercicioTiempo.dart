import 'package:flutterapp/ejercicios/Ejercicio.dart';

class EjercicioTiempo extends Ejercicio{
  String _time;

  EjercicioTiempo(String name, String description, int calories, List<String> tags, String time):
        this._time = time,
        super(name, description, calories, tags);
    get time => this._time;
}
