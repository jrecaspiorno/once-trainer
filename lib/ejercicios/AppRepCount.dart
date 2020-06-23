import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ejercicios/EjercicioRepeticiones.dart';
import 'package:flutterapp/ejercicios/EjerciciosState.dart';


class Repcount extends StatefulWidget {
  final EjercicioRepeticiones ejercicioRepeticiones;
  EjercicioState ejstate;
  Repcount({@required this.ejercicioRepeticiones, @required this.ejstate});
  @override
  _RepCountState createState() =>  _RepCountState();
}

class _RepCountState extends State<Repcount> {
  EjercicioState state;
  int repcount;
  int sercount;
  int reptot;
  int sertot;

  void _rmrep() {
    setState(() {
      if(repcount > 0){
        repcount--;
      
      }
    });
  }

  void _resetrep() {
    setState(() {
<<<<<<< HEAD
      
      repcount = reptot;
=======
      repcount = ej.reps;
>>>>>>> 576c48aeb249c60b0baaa11beacc3d5dc98b2261
    });
  }

  void _rmser() {
    setState(() {
      if(sercount > 0){
        sercount--;
        repcount = reptot;
        state.setSeries(sertot -(sertot-sercount));
      }
    });

  }

  void _resetser() {
    setState(() {
      sercount = sertot;
    });
  }

  void initState() {
    
      state = widget.ejstate;
      repcount = state.getReps;                                                                         
      reptot = state.getReps;                                                                         
      sercount = state.getSeries;
      sertot = state.getSeries;

    
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
