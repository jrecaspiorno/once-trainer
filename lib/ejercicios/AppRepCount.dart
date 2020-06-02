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
                new FloatingActionButton(
                  heroTag: "resetser",
                  onPressed: _resetser,
                  child: new Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.indigo,
                ),
                new Text('$sercount', style: new TextStyle(fontSize: 60.0)),
                new FloatingActionButton(
                  heroTag: "addser",
                  onPressed: _addser,
                  child: new Icon(
                      Icons.add_circle,
                      color: Colors.white),
                  backgroundColor: Colors.indigo,
                ),
              ],
            ),
            new Text("Repeticiones",style: new TextStyle(fontSize: 30.0)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new FloatingActionButton(
                  heroTag: "resetrep",
                  onPressed: _resetrep,
                  child: new Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.indigo,
                ),
                new Text('$repcount', style: new TextStyle(fontSize: 60.0)),
                new FloatingActionButton(
                  heroTag: "addrep",
                  onPressed: _addrep,
                  child: new Icon(
                      Icons.add_circle,
                      color: Colors.white),
                  backgroundColor: Colors.indigo,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
