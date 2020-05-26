
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ejercicios/AppTimer.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/EjercicioTiempo.dart';


class BuildEjercicio extends StatefulWidget {
  Ejercicio ejercicio;

  BuildEjercicio({Ejercicio ejercicio}) {
    this.ejercicio = ejercicio;
  }

  @override
  _BuildEjercicioState createState() => _BuildEjercicioState();
}

class _BuildEjercicioState extends State<BuildEjercicio> {



  @override
  Widget build(BuildContext context) {

    Ejercicio ej = widget.ejercicio;
    EjercicioTiempo dummy;
    bool timeType = ej.runtimeType == dummy.runtimeType;
    return MaterialApp(
      title: 'App actividad física',
      home: Scaffold(
        // Widget con app prediseñada, esquema

        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.ejercicio.name),
          backgroundColor: Colors.indigo,
        ),
        body: Container(

            child: Column(
              children: <Widget>[
                const SizedBox(height: 20,),
                tipoEj(timeType),

                const SizedBox(height: 20,),

                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 19,
                      ),
                      child: Text("Descripcion: " + widget.ejercicio.description, style: TextStyle(
                        fontSize: 27,))
                  ),

                ),
              ],
            )
        ),
      ),
    );
  }
  Widget tipoEj(bool timeType){
    if(timeType) {
      EjercicioTiempo ejt = widget.ejercicio;
      return Container(
        child: AppTimer(time: ejt.time),
      );
    }else{
      return Container(
      child: Text("Ej Repeticiones")
      );
    };
    }
}






