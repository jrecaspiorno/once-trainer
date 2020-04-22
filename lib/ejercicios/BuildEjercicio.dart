import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Ejercicio.dart';

class BuildEjercicio extends StatefulWidget {
  Ejercicio ejercicio;

  BuildEjercicio({Ejercicio ejercicio}) {
    this.ejercicio = ejercicio;
  }

  @override
  _BuildEjercicioState createState() => _BuildEjercicioState();
}

class _BuildEjercicioState extends State<BuildEjercicio> {
  bool startispressed = true;

  bool stopispressed = true;

  bool resetispressd = true;

  String stoptimedisplay = "00:00:00";

  var sWatch = Stopwatch();
  final dur = const Duration(milliseconds: 1);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        ),
        body: Container(

            child: Column(
              children: <Widget>[
                const SizedBox(height: 20,),

                stopwatch(),
                ListTile(
                  title: Text(
                  "Tiempo: "+widget.ejercicio.time,
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),),
                ),
                Text("Descripcion: " + widget.ejercicio.description, style: TextStyle(
                  fontSize: 20,
                ),)
              ],
            )
        ),
      ),
    );
  }

  void startTimer(){
    Timer(dur, keeprunning);
  }

  void keeprunning(){
    if(sWatch.isRunning){
      startTimer();
    }
    setState(() {
      stoptimedisplay = sWatch.elapsed.inMinutes.toString().padLeft(2, "0")+ ":"
          + (sWatch.elapsed.inSeconds%60).toString().padLeft(2,"0") + ":"
          + (sWatch.elapsed.inMilliseconds%60).toString().padLeft(2,"0");
    });
  }

  void startStopwatch(){
    setState(() {
      stopispressed = false;
    });
    sWatch.start();
    startTimer();
  }

  void stopStopwatch(){
    setState(() {
      stopispressed = true;
      resetispressd = false;
    });
    sWatch.stop();
  }

  void resetStopwatch(){
    setState(() {
      startispressed = true;
      resetispressd = true;
    });
    sWatch.reset();
    stoptimedisplay = "00:00:00";
  }

  Widget stopwatch() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(stoptimedisplay, style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.w900,
            ),),
          ),
          const SizedBox(height: 20,),
          Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: startispressed ? startStopwatch : null,
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),

                      ),
                      child: Text("Start", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),),
                    ),
                    RaisedButton(
                      onPressed: stopispressed ? null : stopStopwatch,
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),

                      ),
                      child: Text("Stop", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),),
                    ),
                    RaisedButton(
                      onPressed: resetispressd ? null : resetStopwatch,
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),

                      ),
                      child: Text("Reset", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),),
                    )
                  ],
                )
              ],
            ),
          )


        ],
      ),
    );
  }
}






