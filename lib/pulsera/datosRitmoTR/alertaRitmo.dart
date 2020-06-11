import 'package:flutter/material.dart';

class MyRitmo extends StatefulWidget {

  @override
  _MyRitmoCardiaco createState() => _MyRitmoCardiaco();
}

class _MyRitmoCardiaco extends  State<MyRitmo> {
  /*void initState() {
    super.initState();
    //getHealthRate();
  }*/

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          "Alerta!", style: TextStyle(color: Colors.white, fontSize: 30)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Cuidado tu ritmo cardiaco es muy alto.',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            //Text('Estas de acuerdo.', style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
      actions: [
        FlatButton(
          textColor: Colors.white,
          child: Text('Aceptar', style: TextStyle(fontSize: 20)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      backgroundColor: Colors.indigo,
    );
  }
}


/*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          backgroundColor: Colors.indigo,
        ),
        body: !exceso
            ? Text("Error", style: TextStyle(fontSize: 30))
            : AlertDialog(
              title: Text("Alerta!", style: TextStyle(color: Colors.white, fontSize: 30)),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Cuidado tu ritmo cardiaco es muy alto.', style: TextStyle(color: Colors.white, fontSize: 20)),
                    //Text('Estas de acuerdo.', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
              actions: [
                FlatButton(
                  textColor: Colors.white,
                  child: Text('Aceptar', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                /*
                FlatButton(
                  child: Text('Si'),
                  textColor: Colors.white,
                  //onPressed: Navigator.of(context).pop,
                ),
                */
              ],
              backgroundColor: Colors.indigo,
           ),
      ),
    );
  }
  */