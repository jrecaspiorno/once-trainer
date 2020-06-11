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
    return new Container(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text("Series",style: new TextStyle(fontSize: 30.0)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new RaisedButton(
                  onPressed: _resetser,
                  color: Colors.indigo,
                  child: new Text("Resetear \n Series", style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                new Text('$sercount', style: new TextStyle(fontSize: 60.0)),
                new RaisedButton(
                  onPressed: _addser,
                  color: Colors.indigo,

                  child: new Text("Serie \n Completada", style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),
                )

                  ],
            ),
            new Text("Repeticiones",style: new TextStyle(fontSize: 30.0)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new RaisedButton(
                  onPressed: _resetrep,
                  color: Colors.indigo,

                  child: new Text("Resetear \n Repeticiones", style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                new Text('$repcount', style: new TextStyle(fontSize: 60.0)),
                new RaisedButton(
                  onPressed: _addrep,
                  color: Colors.indigo,

                  child: new Text("Repeticion \n Completada", style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
