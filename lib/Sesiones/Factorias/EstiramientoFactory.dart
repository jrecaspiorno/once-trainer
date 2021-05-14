




import 'package:flutterapp/Sesiones/Transfers/Estiramiento.dart';

class FactoriaEstiramiento {

  static EjEstiramiento GenerateEjS(var file) {
    var ej;
    int id = int.parse(file
        .findAllElements("id")
        .first
        .text);
    String name = file
        .findAllElements('nombre')
        .first
        .text;

    String musc = file
        .findAllElements("musculo")
        .first
        .text;
    String desc = file
        .findAllElements("descripcion")
        .first
        .text;
    String pasos = file
        .findAllElements("pasos")
        .first
        .text;






    ej = EjEstiramiento(id, name, musc, desc, pasos);

    return ej;
  }
}