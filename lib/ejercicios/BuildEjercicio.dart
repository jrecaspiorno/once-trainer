import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ejercicios/AppTimer.dart';

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



  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    Ejercicio ej = widget.ejercicio;

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

                AppTimer(time: ej.time,),

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

}






