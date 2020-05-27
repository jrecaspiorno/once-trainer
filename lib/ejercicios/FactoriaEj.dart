import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/EjercicioRepeticiones.dart';
import 'package:flutterapp/ejercicios/EjercicioTiempo.dart';
import 'package:xml/xml.dart' as xml;
class FactoriaEj {

  static Ejercicio GenerateEj(var file) {
    var ej;
    String type = file.findAllElements("type").first.text;
    String name = file
        .findAllElements('name')
        .first
        .text;
    print(name);
    int cal = int.parse(file
        .findAllElements("calories")
        .first
        .text);
    String desc = file
        .findAllElements("description")
        .first
        .text;


    List<String> tags = new List<String>();
    final tagsl = file.findAllElements('tag');
    tagsl.map((node) => node.text).forEach(print);
    for(var t in tagsl){
      tags.add(t.text);
    }

/*
    var tags = file.findAllElements("tag").map((element) {
      return element.text;
    }).toList();
*/

    switch (type) {
      case "time":
        {
          String time = file
              .findAllElements("time")
              .first
              .text;
          ej = EjercicioTiempo(name, desc,cal,tags , time);
        }
        break;
      case "rep":
        {
          String series = file
              .findAllElements("series")
              .first
              .text;
          String reps = file
              .findAllElements("reps")
              .first
              .text;
          ej = EjercicioRepeticiones(name, desc, cal, tags, series, reps);
        }
        break;
    }
    return ej;
  }
}