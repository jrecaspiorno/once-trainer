import 'package:flutter/material.dart';
import 'package:health/health.dart';

import 'sacaDatos.dart';

class MyPideDatos extends StatelessWidget {

  bool _trataDatos (){
    var _healthDataList = getHealthRate(); // Revisar

    // FCmax = 220 - edad
    // Ej: 50 años, serian 170 latidos por minuto

    //var it = _healthDataList.iterator;
    HealthDataPoint aux;
    int cont = 0, suma = 0, poda = 1;
    double media;
    Iterator it = _healthDataList.iterator;
    while(it.current != _healthDataList.last && poda != 3){
      aux = it.current;
      if(aux.dataType == "HEART_RATE"){
        suma += aux.value;
        cont++;
        poda = 2;
      }
      else if(poda == 2)
        poda = 3;
      it.moveNext();
    }
    media = suma / cont;
    // if (media > (220 - edad)) // Edad se saca de la base de datos
    if(media > 180)
      return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (_trataDatos()) {
      return AlertDialog(
        title: Text("Cuidado!"),
        content: Text("Seguir?"),
        actions: [
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('Si'),
            //onPressed: Navigator.of(context).pop,
          ),
        ],
        backgroundColor: Colors.indigo,
      );
    }
  }
}