import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTimer extends StatefulWidget{
  String time;

  AppTimer({String time}) {
    this.time = time;
  }
  
  @override
  State<StatefulWidget> createState()  => _AppTimerState();



}

class _AppTimerState extends State<AppTimer>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return stopwatch(widget.time);
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
          if(time4Timer < 1 ) {

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