import 'package:flutterapp/ejercicios/Ejercicio.dart';

class EjercicioRepeticiones extends Ejercicio{
  String _reps;
  String _series;
  EjercicioRepeticiones(String name, String description, int calories, List<String> tags, String series, String reps) :
      this._reps = reps,
    this._series = series,
        super(name, description, calories, tags);
  get reps => this._reps;
  get series => this._series;
}
