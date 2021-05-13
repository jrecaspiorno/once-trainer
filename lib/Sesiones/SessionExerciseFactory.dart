import 'package:flutterapp/Sesiones/SessionsExercise.dart';

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
    int series;
    String time;
    List<String> tags = [];
    String gp = file
        .findAllElements("principal")
        .first
        .text;
    final tagsl = file.findAllElements('tag');
    tagsl.map((node) => node.text).forEach(print);
    for(var t in tagsl){
      tags.add(t.text);
    }
    switch(nivel) {
      case "i":
        series = int.parse(file.findAllElements('series1')
            .first
            .text);
        time = file.findAllElements('time1')
            .first
            .text;
        break;
      case "a":
        series = int.parse(file.findAllElements('series2')
            .first
            .text);
        time = file.findAllElements('time2')
            .first
            .text;
        break;
    }

    ej = EjSesion(id, name, desc, tags, gp, series, time, video);
    return ej;

  }
}