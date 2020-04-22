import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
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
  static AudioCache player = new AudioCache();
  final String alarmAudioPath  = "assest/Sounds/beep-09.mp3";
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

                stopwatch(widget.ejercicio.time),

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


  bool startispressed = true;

  bool stopispressed = true;

  bool resetispressd = true;


  bool primera = true;

  String stoptimedisplay = "";

  String defaultTime;

  bool checktimer = true;

  int time4Timer = 0;

  void startStopwatch(){
    setState(() {
      startispressed = false;
      stopispressed = false;
      resetispressd = true;
      checktimer = true;
    });
    time4Timer = StringtoTime(stoptimedisplay);
    debugPrint(time4Timer.toString());
    Timer.periodic(Duration(
        seconds: 1), (Timer t){
      setState(() {
        if(time4Timer < 1 || checktimer == false){
          if(time4Timer < 1 ) {player.play(alarmAudioPath);
          stopispressed = true;
          resetispressd = false;
          }

          t.cancel();
          checktimer = true;
        }
        else{
          time4Timer = time4Timer -1;
        }
        stoptimedisplay = TimetoString(time4Timer);
      });
    });



  }

  void stopStopwatch(){

    setState(() {
      startispressed = true;
      stopispressed = true;
      resetispressd = false;
      checktimer = false;
    });

  }

  void resetStopwatch(){
    setState(() {
      startispressed = true;
      resetispressd = true;
      stopispressed = true;
      checktimer = false;
    });
    debugPrint(defaultTime);

    stoptimedisplay = defaultTime;
    debugPrint(stoptimedisplay);
  }
  int StringtoTime(String h){
    return ((int.parse(h[0])*10) + (int.parse(h[1])) * 60 ) + (int.parse(h[3])*10)+ (int.parse(h[4]));
  }
  String TimetoString(int t){
    int min = t ~/60 ;
    int sec = t%60;
    return (min.toString().padLeft(2, "0") + ":"+sec.toString().padLeft(2, "0") );
  }
  Widget stopwatch(String time) {

    if(primera){
      primera = false;
      stoptimedisplay = time;
      defaultTime = time;
    }
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
                      color: Colors.indigo,
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
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    RaisedButton(
                      onPressed: stopispressed ? null : stopStopwatch,
                      color: Colors.indigo,
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
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    RaisedButton(
                      onPressed: resetispressd ? null : resetStopwatch,
                      color: Colors.indigo,
                      padding: EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),

                      ),
                      child: Text("Reset", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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






