import 'package:flutterapp/ejercicios/Ejercicio.dart';

class EjercicioRepeticiones extends Ejercicio{
  int _reps;
  int _series;
  EjercicioRepeticiones(String name, String description, int calories, List<String> tags, int series, int reps) :
      this._reps = reps,
    this._series = series,
        super(name, description, calories, tags);
  get reps => this._reps;
  get series => this._series;
}
