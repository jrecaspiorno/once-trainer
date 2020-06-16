import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RepCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new repcount();
  }
}

class repcount extends StatefulWidget {
  @override
  _repCountState createState() => new _repCountState();
}

class _repCountState extends State<repcount> {
  int repcount = 0;
  int sercount = 0;

  void _addrep() {
    setState(() {
      repcount++;
    });
  }

  void _resetrep() {
    setState(() {
      repcount = 0;
    });
  }

  void _addser() {
    setState(() {
      sercount++;
      repcount = 0;
    });
  }

  void _resetser() {
    setState(() {
      sercount = 0;
    });
  }

  void _init() {
    setState(() {
      repcount = 0;
      sercount = 0;
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
                      onPressed: _addser,
                      child:  Icon(
                        Icons.add_circle,
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
                 Text('$repcount', style: new TextStyle(fontSize: 60.0)),
                Semantics(
                  label: "añadir repeticion",
                  child:FloatingActionButton(
                      heroTag: "add rep",
                      backgroundColor: Colors.indigo,
                      onPressed: _addrep,
                      child:  Icon(
                        Icons.add_circle,
                        color:Colors.white,
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
