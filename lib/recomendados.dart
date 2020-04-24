import 'package:flutter/material.dart';

import 'ejercicios/ejercicioP.dart';

class MyRecom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'App actividad física',
      home: Scaffold( // Widget con app prediseñada, esquema
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Lista Ejercicios'),
            backgroundColor: Colors.indigo,
          ),
          body: ListView(
              children: [
                const SizedBox(height: 20),
                MyRecomType(),
              ]
          )
      ),
    );
  }
}

//
class MyRecomType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          _buildEjer('Ejercicio Ejemplo 1', MyEjercicio1(), context),
          _buildEjer('Ejercicio Ejemplo 3', MyEjercicio3(), context),
        ],
      ),
    );
  }
  Column _buildEjer (String label, Widget funcion, BuildContext context){
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => funcion),
            );
          },
          color: Colors.indigo,
          textColor: Colors.white,
          padding: EdgeInsets.all(24.0),
          child: Text(label, style: TextStyle(fontSize: 30)),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
