import 'package:flutterapp/Calentamiento/EjCalentamiento.dart';

class FactoriaCalentamiento {

  static EjCalentamiento GenerateEjC(var file) {
    var ej;
    int id = int.parse(file
        .findAllElements("id")
        .first
        .text);
    String name = file
        .findAllElements('name')
        .first
        .text;
    print(name);

    String desc = file
        .findAllElements("description")
        .first
        .text;
    int diff = 0;
    String gp = file
        .findAllElements("principal")
        .first
        .text;

    List<String> tags = [];
    final tagsl = file.findAllElements('tag');
    tagsl.map((node) => node.text).forEach(print);
    for(var t in tagsl){
      tags.add(t.text);
    }
    int series = int.parse(file
        .findAllElements("series")
        .first
        .text);
    int reps = int.parse( file
        .findAllElements("reps")
        .first
        .text);
    /*
    var tags = file.findAllElements("tag").map((element) {
      return element.text;
    }).toList();
*/
    ej = EjCalentamiento(id, name, desc, tags, gp, reps, series );

    return ej;
  }
}