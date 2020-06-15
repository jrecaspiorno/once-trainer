
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ejercicios/AppTimer.dart';
import 'package:flutterapp/ejercicios/AppRepCount.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/EjercicioTiempo.dart';
//import 'package:flutterapp/pulsera/datosRitmoTR/alertaRitmo.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/sacaDatosRitmoCardiaco.dart';

import 'package:flutterapp/Data/moor_database.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'dart:async';


class BuildEjercicio extends StatefulWidget {
  Ejercicio ejercicio;

  BuildEjercicio({Ejercicio ejercicio}) {
    this.ejercicio = ejercicio;
  }

  @override
  _BuildEjercicioState createState() => _BuildEjercicioState();
}

class _BuildEjercicioState extends State<BuildEjercicio> {

  Timer timer;
  bool auxParar = true;
  @override
  void initState() {
    super.initState();
    //int edad = sacarEdad(); no va por el future
    timer = Timer.periodic(Duration(seconds: 2), (Timer t){
      if(auxParar) {
        sacarEdad();
        auxParar = false;
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


 void sacarEdad ()async {

    DateTime endDate = DateTime.now();
    /*
    final database = Provider.of<AppDatabase>(context, listen: false);
    var state = context.read<LoginState>();
    String id = state.getId();
    var user = await database.usuarioDAO.getUser(id);
    var fecha_n = user.edad.year; // En teoria pasamos solo el año
    //print(fecha_n);
    var edad = endDate.year - fecha_n;
    if(edad == null){
      edad = 50;
    }
  */
    int edad = 50;
    getHealthRate(edad, context);
    // return  edad;

  }
  @override
  Widget build(BuildContext context) {

    Ejercicio ej = widget.ejercicio;

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
               // MyRitmo(),
                const SizedBox(height: 20,),
                widgetEj(ej),

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
  Widget widgetEj(Ejercicio ejercicio){
    if(ejercicio is EjercicioTiempo) {
      EjercicioTiempo ejt = widget.ejercicio;
      return Container(
        child: AppTimer(time: ejt.time),
      );
    }else{
      return Container(
          child: RepCounter(),
      );
    };
  }
}






