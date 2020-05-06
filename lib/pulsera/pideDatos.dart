import 'package:flutter/material.dart';
import 'package:health/health.dart';

import 'sacaDatos.dart';

class MyPideDatos extends StatelessWidget {

  bool _trataDatos (){
    var _healthDataList = getHealthRate(); // Revisar

    // FCmax = 220 - edad
    // Ej: 50 años, serian 17 latidos por minuto

    //var it = _healthDataList.iterator;
    Iterator it = _healthDataList.iterator;
    while(it.current != _healthDataList.last){

      it.moveNext();
    }
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