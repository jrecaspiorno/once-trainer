import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ejercicios/EjercicioRepeticiones.dart';

class RepCounter extends StatelessWidget {
  final EjercicioRepeticiones ej;
  RepCounter({@required this.ej});
  @override
  Widget build(BuildContext context) {
    return  Repcount(ejercicioRepeticiones: ej,);
  }
}

class Repcount extends StatefulWidget {
  final EjercicioRepeticiones ejercicioRepeticiones;
  Repcount({@required this.ejercicioRepeticiones});
  @override
  _RepCountState createState() =>  _RepCountState();
}

class _RepCountState extends State<Repcount> {
  EjercicioRepeticiones ej;

  int repcount = 2 ;
  int sercount = 3;
  final ser = 3;
  final rep =2;

  void _rmrep() {
    setState(() {
      repcount--;
    });
  }

  void _resetrep() {
    setState(() {
      repcount = rep;
    });
  }

  void _rmser() {
    setState(() {
      sercount--;
      repcount = ser ;
    });
  }

  void _resetser() {
    setState(() {
      sercount = ser;
    });
  }

  void init() {
    setState(() {
      ej = widget.ejercicioRepeticiones;
      repcount = ej.reps;                                                                         
      sercount =ej.series;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child:  Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
             Text("Series",style:  TextStyle(fontSize: 30.0)),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Semantics(
                  label: "Resetear series",
                  child:FloatingActionButton(
                    heroTag: "reset series",
                    backgroundColor: Colors.indigo,
                    onPressed: _resetser,
                    child:  Icon(
                        Icons.refresh,
                        color:Colors.white,
                    )
                  ),
                ),
                 Text('$sercount', style:  TextStyle(fontSize: 60.0)),
                Semantics(
                  label: "añadir serie",
                  child:FloatingActionButton(
                      heroTag: "add series",
                      backgroundColor: Colors.indigo,
                      onPressed: _rmser,
                      child:  Icon(
                        Icons.remove_circle,
                        color:Colors.white,
                      )
                  ),
                ),

                  ],
            ),
             Text("Repeticiones",style:  TextStyle(fontSize: 30.0)),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Semantics(
                  label: "resetear repeticiones",
                  child:FloatingActionButton(
                      heroTag: "reset rep",
                      backgroundColor: Colors.indigo,
                      onPressed: _resetrep,
                      child:  Icon(
                        Icons.refresh,
                        color:Colors.white,
                      )
                  ),
                ),
                 Text('$repcount', style:  TextStyle(fontSize: 60.0)),
                Semantics(
                  label: "añadir repeticion",
                  child:FloatingActionButton(
                      heroTag: "add rep",
                      backgroundColor: Colors.indigo,
                      onPressed: _rmrep,
                      child:  Icon(
                        Icons.remove_circle,
                        color:Colors.white
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
