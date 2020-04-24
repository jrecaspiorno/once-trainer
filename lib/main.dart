import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import 'Perfil/Perfil.dart';
import 'ejercicios/Ejercicio.dart';
import 'lista_ejer.dart';
import 'pulsera/pulsera.dart';
import 'recomendados.dart';

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
            backgroundColor: Colors.indigo,
          ),
          body: MyButtonType(),
        ),
      );
  }
}

class MyButtonType extends StatelessWidget {


  Future<List<Ejercicio>> getEjercicios(BuildContext context) async {
    List<String> XMLS = List();
    List <Ejercicio> ejercicios = List();
    XMLS = ["Caminar.xml", "Ej1.xml"];
    for(int i = 0; i < XMLS.length ; ++i){
      String xmlS =  await DefaultAssetBundle.of(context).loadString("todos_ejercicios/"+XMLS[i]);
      var file = xml.parse(xmlS);
      Ejercicio ej = Ejercicio(file.findAllElements('name').first.text
      , file.findAllElements("time").first.text
      , file.findAllElements("description").first.text
      ,  int.parse(file.findAllElements("calories").first.text));

      ejercicios.add(ej);


    }

    return ejercicios;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildButton('Recomendaciones', MyRecom(), context),
          _buildButton('Lista Ejercicios', MyList(), context),
          _buildButton('Perfil', MyProfile.fromMyProfile(), context),
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