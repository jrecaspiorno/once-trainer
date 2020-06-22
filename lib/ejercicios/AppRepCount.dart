import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ejercicios/EjercicioRepeticiones.dart';
import 'package:flutterapp/ejercicios/EjerciciosState.dart';

class RepCounter extends StatelessWidget {
  final EjercicioRepeticiones ej;
  final EjercicioState state;
  RepCounter({@required this.ej, @required this.state});
  @override
  Widget build(BuildContext context) {
    return  Repcount(ejercicioRepeticiones: ej, ejstate: state,);
  }
}

class Repcount extends StatefulWidget {
  final EjercicioRepeticiones ejercicioRepeticiones;
  EjercicioState ejstate;
  Repcount({@required this.ejercicioRepeticiones, @required this.ejstate});
  @override
  _RepCountState createState() =>  _RepCountState();
}

class _RepCountState extends State<Repcount> {
  EjercicioRepeticiones ej;
  EjercicioState state;
  int repcount;
  int sercount;
  

  void _rmrep() {
    setState(() {
      if(repcount > 0){
        repcount--;
      
      }
    });
  }

  void _resetrep() {
    setState(() {
      
      repcount = ej.reps;
    });
  }

  void _rmser() {
    setState(() {
      if(sercount > 0){
        sercount--;
        repcount = ej.reps;
        state.setSeries(ej.series -(ej.series-sercount));
      }
    });

  }

  void _resetser() {
    setState(() {
      sercount = ej.series;
    });
  }

  void initState() {
    
      ej = widget.ejercicioRepeticiones;
      state = widget.ejstate;
      repcount = ej.reps;                                                                         
      sercount =ej.series;
    
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
                  button: true,
                  excludeSemantics: true,
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
                  button: true,
                  excludeSemantics: true,
                  label: "serie realizada",
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
                  button: true,
                  excludeSemantics: true,
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
                  label: "repetición realizada",
                  excludeSemantics: true,
                  button: true,
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
