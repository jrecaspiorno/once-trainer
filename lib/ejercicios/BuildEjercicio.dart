
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/ejercicios/AppTimer.dart';
import 'package:flutterapp/ejercicios/AppRepCount.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/EjercicioRepeticiones.dart';
import 'package:flutterapp/ejercicios/EjercicioTiempo.dart';

//import 'package:flutterapp/pulsera/datosRitmoTR/alertaRitmo.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/sacaDatosRitmoCardiaco.dart';

import 'package:flutterapp/Data/moor_database.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'dart:async';

import 'EjercicioRepeticiones.dart';
import 'EjerciciosState.dart';
import 'lista_ejer.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class BuildEjercicio extends StatefulWidget {
  Ejercicio ejercicio;
  BuildEjercicio({@required this.ejercicio});



  @override
  _BuildEjercicioState createState() => _BuildEjercicioState();
}

class _BuildEjercicioState extends State<BuildEjercicio> {

  Timer timer;
  AudioCache _audioCache;
  bool sacaaudio = false;
  int cont = 0;

  @override
  void initState() {
    super.initState();
    //int edad = sacarEdad(); no va por el future
    setAuxExceso(false);
    _audioCache = AudioCache(prefix: "audio/", fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
    timer = Timer.periodic(Duration(seconds: 3), (Timer t){ // En principio cada 3 seg
      if(!getAuxExceso()) { // Si no salta la alerta
        sacarEdad();
        cont = 0;
      }
      else{ // Si salta
        cont++;
        print(cont);
        if(!sacaaudio) {
          _audioCache.play("beep-09.mp3");
          sacaaudio = true;
        }
        if(cont == 4) {
          setAuxExceso(false);
          sacaaudio = false;
        }
      }
    });
  }

  void botonHecho(BuildContext context,EjercicioState ejstate){
    Alerts alerta = Alerts(
      context: context,
      title: "Ejercicio Completado",
      message: "¿Que datos deseas usar?",

      firstButtonText: "Datos del Ejercicio",
      secondButtonText: "Datos del Usuario",
      thirdButtonText: "cancelar",
      fun1:()=> addEjercicio(context,ejstate),
      fun2:()=>addEjercicioBase(context, ejstate),
      fun3:()=> Navigator.of(context, rootNavigator: true).pop(),


    );
    alerta.showAlertDialog3();
    return;
  }
  addEjercicioBase(BuildContext context,EjercicioState ejstate){
    if(ejstate is EjercicioTiempo){
      EjercicioTiempo aux = ejstate.getEjercicio();
      ejstate.setTiempo(aux.time);
    }else{
      EjercicioRepeticiones aux = ejstate.getEjercicio();
      ejstate.setReps(aux.reps);
      ejstate.setReps(aux.series);
    }
    addEjercicio(context, ejstate);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  void addEjercicio(BuildContext context, EjercicioState ejstate) async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    var state = Provider.of<LoginState>(context, listen: false);
    String uid = state.getId();
    if (widget.ejercicio is EjercicioTiempo) {
      EjercicioTiempo ej = widget.ejercicio;
      Historial hist = Historial(
          dificultad: 0,
          ejercicio: widget.ejercicio.name,
          fecha: DateTime.now(),
          calorias: widget.ejercicio.calories,
          tipo: "tiempo",
          duracion: ejstate.getTime(),
          series: null,
          repeticiones: null,
          idUser: uid,
          activo: true);
      database.historialDAO.insertHistorial(hist);
    } else {
      EjercicioRepeticiones ej = widget.ejercicio;
      Historial hist = Historial(
          dificultad: 0,
          ejercicio: widget.ejercicio.name,
          fecha: DateTime.now(),
          calorias: widget.ejercicio.calories,
          tipo:"reps",
          duracion: null,
          series: ejstate.getSeries(),
          repeticiones: ejstate.getReps(),
          idUser: uid,
          activo: true);
        database.historialDAO.insertHistorial(hist);

    }
    Navigator.pop(context);
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
  */var state = context.read<LoginState>();
    //state.setDate(_dateTime);
    //print(state.getFNacimiento());
    int edad = endDate.year - state.getFNacimiento().year;
    //print(edad);
    //int edad = 50;
    getHealthRate(edad, context); // Si true es que se ha pasado
    // return  edad;
  }



  Widget widgetEj(Ejercicio ejercicio, EjercicioState ejstate) {
    if (ejercicio is EjercicioTiempo) {
      EjercicioTiempo ejt = widget.ejercicio;
      ejstate.setTiempo(ejt.time);
      ejstate.setTipo("T");
      return Container(
        child: AppTimer(time: ejt.time),
      );
    } else {
      EjercicioRepeticiones ejr = widget.ejercicio;
      ejstate.setSeries(0);
      ejstate.setReps(ejr.reps);
      ejstate.setTipo("R");
      return Container(
        child: Repcount(ejercicioRepeticiones: ejr,ejstate: ejstate,),
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    Ejercicio ej = widget.ejercicio;
    var ejstatus = context.watch<EjercicioState>();
    ejstatus.setEjercicio(ej);
    return  WillPopScope(
        onWillPop:() {
          print('Backbutton pressed (device or appbar button), do whatever you want.');
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
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
              const SizedBox(
                height: 20,
              ),
              widgetEj(ej, ejstatus),

              const SizedBox(
                height: 20,
              ),

              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 19,
                    ),
                    child: Text("Descripcion: " + widget.ejercicio.description,
                        style: TextStyle(
                          fontSize: 27,
                        ))),
              ),
              const SizedBox(
                height: 20,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                autofocus: true,
                color: Colors.indigo,
                onPressed:() => botonHecho(context, ejstatus),
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Hecho",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
        ),
    );
  }
}
