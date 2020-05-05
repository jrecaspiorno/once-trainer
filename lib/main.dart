import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:provider/provider.dart';

import 'Login.dart';
import 'Menu/Menu.dart';


Future<void> main() async {
  debugPrint = (String message, {int wrapWidth}) {};
  developer.log('log me', name: 'once_trainer');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override // Sobrescribir para indicar que creamos nuestro widget
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AppDatabase(),
      child: MaterialApp(
        title: 'App actividad física',
        home: Scaffold(
          // Widget con app prediseñada, esquema
          appBar: AppBar(
            title: Text('Home'),
            backgroundColor: Colors.indigo,
          ),
          body: Home(),
        ),
      ),
    );
  }
}



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildButton('Login', Login(database.usuarioDAO) , context),
          _buildButton('Menu', Menu() , context)
        ],
      ),
    );
  }

  Column _buildButton(String label, Widget funcion, BuildContext context) {
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





