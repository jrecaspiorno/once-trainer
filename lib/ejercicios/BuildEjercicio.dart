import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/HiveData/RecomendadorList/RecomList.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:flutterapp/ejercicios/AppRepCount.dart';
import 'package:flutterapp/ejercicios/AppTimer.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/EjercicioRepeticiones.dart';
import 'package:flutterapp/ejercicios/EjercicioTiempo.dart';
import 'package:flutterapp/pulsera/datosRitmoTR/sacaDatosRitmoCardiaco.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'EjercicioRepeticiones.dart';
import 'EjerciciosState.dart';

class BuildEjercicio extends StatefulWidget {
  Ejercicio ejercicio;
  String route;
  BuildEjercicio({@required this.ejercicio, @required this.route});
  @override
  _BuildEjercicioState createState() => _BuildEjercicioState();
}

class _BuildEjercicioState extends State<BuildEjercicio> {
  final NavigationService _navigationService = locator<NavigationService>();
  Timer timer;
  AudioCache _audioCache;
  bool sacaaudio = false;
  int cont = 0;
  Box recomListBox;
  @override
  void initState() {
    super.initState();
    //int edad = sacarEdad(); no va por el future

    setAuxExceso(false);
    _audioCache = AudioCache(
        prefix: "audio/",
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      // En principio cada 3 seg
      if (!getAuxExceso()) {
        // Si no salta la alerta
        sacarEdad();
        cont = 0;
      } else {
        // Si salta
        cont++;
        print(cont);
        if (!sacaaudio) {
          _audioCache.play("beep-09.mp3");
          sacaaudio = true;
        }
        if (cont == 4) {
          setAuxExceso(false);
          sacaaudio = false;
        }
      }
    });
  }

  addEjercicioBase(BuildContext context, EjercicioState ejstate) {
    dynamic aux = widget.ejercicio;
    if (aux is EjercicioTiempo) {
      aux.setTime(ejstate.getTime);
    } else {
      aux.setReps(ejstate.getReps);
      aux.setSeries(ejstate.getSeries);
    }
    addEjercicio(context, ejstate, aux, false);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void addEjercicio(BuildContext context, EjercicioState ejstate, Ejercicio aux,
      bool ok) async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    var state = Provider.of<LoginState>(context, listen: false);
    var r2;
    String uid = state.getId();
    if (aux is EjercicioTiempo) {
      EjercicioTiempo ej = aux;
      EjercicioTiempo au = widget.ejercicio;
      if (true) {
        ejstate.setTiempo(au.time);
        aux.setTime(ejstate.getTime);
      }
      Historial hist = Historial(
          dificultad: ej.dificultad,
          ejercicio: widget.ejercicio.name,
          fecha: DateTime.now(),
          calorias: widget.ejercicio.calories,
          tipo: "tiempo",
          duracion: ej.time,
          series: null,
          repeticiones: null,
          idUser: uid,
          activo: true);
      await database.historialDAO.insertHistorial(hist);
    } else {
      EjercicioRepeticiones ej = aux;
      ej.setReps(ejstate.getReps);
      Historial hist = Historial(
          dificultad: ej.dificultad,
          ejercicio: widget.ejercicio.name,
          fecha: DateTime.now(),
          calorias: widget.ejercicio.calories,
          tipo: "reps",
          duracion: null,
          series: ej.series,
          repeticiones: ej.reps,
          idUser: uid,
          activo: true);
      database.historialDAO.insertHistorial(hist);
    }
    try {
      RecomList r = recomListBox.values.singleWhere((element) {
        var x = element as RecomList;
        return x.tipo == widget.ejercicio.grupoprincipal;
      });
      var auxhechos = r.hechosTotales;
      var k = r.key;
      auxhechos++;
      recomListBox.putAt(
          k, RecomList(r.tipo, r.ejercicios, r.hechosLista, auxhechos));
      r2 = recomListBox.values;
    } catch (e) {} finally {
      _navigationService.goBack();
      _navigationService.replaceView(widget.route);
    }
  }

  void sacarEdad() async {
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
    var state = context.read<LoginState>();
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
        child: AppTimer(time: ejstate.getTime),
      );
    } else {
      EjercicioRepeticiones ejr = widget.ejercicio;
      ejstate.setSeries(ejr.series);
      ejstate.setReps(ejr.reps);
      ejstate.setTipo("R");
      return Container(
        child: Repcount(
          ejercicioRepeticiones: ejr,
          ejstate: ejstate,
        ),
      );
    }
  }

  _initBox() async {
    recomListBox = await Hive.openBox('recomlists');
  }

  @override
  Widget build(BuildContext context) {
    _initBox();
    Ejercicio ej = widget.ejercicio;
    var ejstatus = context.watch<EjercicioState>();
    ejstatus.setEjercicio(ej);

    Alerts alert = Alerts(
        context: context,
        firstButtonText: "Cancelar",
        secondButtonText: "Terminar",
        thirdButtonText: "Añadir",
        fun1: () => _navigationService.goBack(),
        fun2: () {
          _navigationService.goBack();
          addEjercicioBase(context, ejstatus);
        },
        fun3: () {
          _navigationService.goBack();
          addEjercicio(context, ejstatus, widget.ejercicio, true);
        },
        title: "Ejercicio terminado",
        message:
            "Ejercico terminado, ¿desea añadir los datos del ejercicio o terminarlo?");

    return WillPopScope(
      onWillPop: () {
        print(
            'Backbutton pressed (device or appbar button), do whatever you want.');
        _navigationService.goBack();
        return Future.value(false);
      },
      child: Scaffold(
        // Widget con app prediseñada, esquema

        appBar: AppBar(
          leading: BackButton(
            onPressed: _navigationService.goBack,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  autofocus: true,
                  color: Colors.pink,
                  onPressed: () => alert.showAlertDialog3(),
                  //addEjercicioBase(context, ejstatus),
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
                Padding(
                  padding: EdgeInsets.all(16.0),
                ),
              ],
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
