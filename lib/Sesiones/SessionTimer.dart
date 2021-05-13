import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AppSTimer extends StatefulWidget {
  AppSTimer({@required this.time});
  String time;

  @override
  State<StatefulWidget> createState() => _AppSTimerState();
}

class _AppSTimerState extends State<AppSTimer> {
  bool checktimer = true;
  String defaultTime;
  bool primera = true;
  bool resetispressd = true;
  bool startispressed = true;
  bool stopispressed = true;
  String stoptimedisplay = "";
  int time4Timer = 0;

  AudioCache _audioCache;

  void initState() {
    super.initState();
    _audioCache = AudioCache(
        prefix: "audio/",
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
  }

  void startStopwatch() {
    setState(() {
      startispressed = false;
      stopispressed = false;
      resetispressd = true;
      checktimer = true;
    });
    time4Timer = stringtoTime(stoptimedisplay);
    debugPrint(time4Timer.toString());
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          if (time4Timer < 1 || checktimer == false) {
            if (time4Timer < 1) {
              _audioCache.play("beep-09.mp3");
              stopispressed = true;
              resetispressd = false;
            }

            t.cancel();
            checktimer = true;
          } else {
            time4Timer = time4Timer - 1;
          }
          stoptimedisplay = timetoString(time4Timer);
          int ti = stringtoTime(defaultTime);
          int r = ti - time4Timer;
        });
      }
    });
  }

  void stopStopwatch() {
    sleep(Duration(seconds: 1));
    setState(() {
      startispressed = true;
      stopispressed = true;
      resetispressd = false;
      checktimer = false;
    });
  }

  void resetStopwatch() {
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

  int stringtoTime(String h) {
    return ((int.parse(h[0]) * 10) + (int.parse(h[1])) * 60) +
        (int.parse(h[3]) * 10) +
        (int.parse(h[4]));
  }

  String timetoString(int t) {
    int min = t ~/ 60;
    int sec = t % 60;
    return (min.toString().padLeft(2, "0") +
        ":" +
        sec.toString().padLeft(2, "0"));
  }

  String labelStopwatch() {
    var separar = stoptimedisplay.split(":");
    String primeraParte;

    if (separar.first[0] == '0')
      primeraParte = separar.first[1];
    else
      primeraParte = separar.first;
    String segundaParte = separar.last;
    return primeraParte + "minutos y " + segundaParte + "segundos";
  }

  Widget stopwatch(String time) {
    if (primera) {
      primera = false;
      stoptimedisplay = time;
      defaultTime = time;
    }
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Semantics(
              excludeSemantics: true,
              label: labelStopwatch(),
              child: Text(
                stoptimedisplay,
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        "Empezar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: stopispressed ? null : stopStopwatch,
                      color: Colors.indigo,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        "Parar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: resetispressd ? null : resetStopwatch,
                      color: Colors.indigo,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        "Reiniciar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
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

  @override
  Widget build(BuildContext context) {

    return  stopwatch(widget.time);
  }
}
