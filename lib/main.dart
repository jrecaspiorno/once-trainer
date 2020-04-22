import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'Perfil.dart';
import 'lista_ejer.dart';
import 'recomendados.dart';
import 'pulsera/pulsera.dart';

void main(){
  // Instancia un objeto, es como poner (new Center())
  debugPrint = (String message, {int wrapWidth}) {};
  developer.log('log me', name: 'once_trainer');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override // Sobrescribir para indicar que creamos nuestro widget

  Widget build(BuildContext context) {
    // TODO: implement build
      return MaterialApp(
        title: 'App actividad física',
        home: Scaffold( // Widget con app prediseñada, esquema
          appBar: AppBar(
            title: Text('Menu'),
          ),
          body: MyButtonType(),
        ),
      );
  }
}

class MyButtonType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildButton('Recomendaciones', MyRecom(), context),
          _buildButton('Lista Ejercicios', MyList(), context),
          _buildButton('Perfil', MyProfile(), context),
          _buildButton('Prueba pulsera', MyPulsera(), context),
        ],
      ),
    );
  }
    Column _buildButton (String label, Widget funcion, BuildContext context){
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
            color: Colors.blue,
            textColor: Colors.white,
            padding: EdgeInsets.all(24.0),
            child: Text(label, style: TextStyle(fontSize: 30)),
          ),
          const SizedBox(height: 40),
        ],
      );
    }
  }