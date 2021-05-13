import 'package:flutterapp/Sesiones/Session.dart';
import 'package:xml/xml.dart';

class FactoriaSesion{

  static Session GenerateSession(XmlElement data) {
    var ses;
    var sesid = int.parse(data
        .findAllElements("id")
        .first
        .text);
    String nameid = data
        .findAllElements('nameid')
        .first
        .text;
    String name = data
        .findAllElements('name')
        .first
        .text;
    List<SubSession> subsesions = [];
    var subsess = data.findAllElements("parte");
    subsess.forEach((sub) {
      var number = int.parse(sub
          .findAllElements("numero")
          .first
          .text);
      String n = sub.findAllElements("nombre").first.text;
      var p = sub.findAllElements("principiante").toList();
      var a = sub.findAllElements("avanzado").toList();
      Tarea principiante = Tarea(p[0].findAllElements('descanso').first.text, int.parse(p[0].findAllElements('series').first.text), p[0].findAllElements('trabajo').first.text);
      Tarea avanzado = Tarea(a[0].findAllElements('descanso').first.text, int.parse(a[0].findAllElements('series').first.text), a[0].findAllElements('trabajo').first.text);
      subsesions.add(SubSession(n, principiante, avanzado, number));
    });
    ses = Session(sesid, subsesions, name, nameid);
    return ses;
  }

}