


import 'package:flutterapp/Sesiones/Transfers/SessionsExercise.dart';

class FactoriaEjSesion {
  static EjSesion GenerateEjSesion(var file , String nivel) {
    var ej;
    int id = int.parse(file
        .findAllElements("id")
        .first
        .text);
    String name = file
        .findAllElements('name')
        .first
        .text;
    String video = file
        .findAllElements('video')
        .first
        .text;
    String desc = file
        .findAllElements('description')
        .first
        .text;



    ej = EjSesion(id, name, desc, video);
    return ej;

  }
}