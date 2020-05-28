import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/sacaDatosRitmoCardiaco.dart';
import 'package:health/health.dart';
import 'package:provider/provider.dart';

/*
class MyPideDatos extends StatelessWidget {
  var _healtDataList;
  MyPideDatos( List<HealthDataPoint> lista){
    this._healtDataList = lista;
  }

  bool _trataDatos (List<HealthDataPoint> _healthDataList){
    //var _healthDataList = getHealthRate(); // Revisar

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
    if (_trataDatos(_healtDataList)) {
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

 */

bool trataDatos (List<HealthDataPoint> _healthDataList){
  //final database = Provider.of<AppDatabase>(context);
  
  //var state = context.watch<LoginState>();
  //String id = state.getId();
  //var user = await database.usuarioDAO.getUser(id)
  //var fecha_n = user.edad;
  //var _healthDataList = getHealthRate(); // Revisar

  // FCmax = 220 - edad
  // Ej: 50 años, serian 170 latidos por minuto

  //var it = _healthDataList.iterator;
  print(_healthDataList);

  HealthDataPoint aux;
  int cont = 0, poda = 1;
  double media,  suma = 0;
  Iterator it = _healthDataList.iterator;

  for(int i = 0; i < _healthDataList.length; i++){
    suma += _healthDataList[i].value;
    cont++;
  }
  /*
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
  */
  media = (suma / cont);
  print(media);
  // if (media > (220 - edad)) // Edad se saca de la base de datos
  if(media > 10)
    return true;
  return false;
}