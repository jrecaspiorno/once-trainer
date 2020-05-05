import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Perfil/Perfil.dart';
import 'package:flutterapp/pulsera/pulsera.dart';

import '../lista_ejer.dart';
import '../recomendados.dart';

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
        ),
        body: MenuView(context),
      ),
    );
  }

  Widget MenuView(BuildContext context) {
    return Center(
      child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                _buildButton('Recomendaciones', MyRecom(), context),
                _buildButton('Lista Ejercicios', MyList(), context),
                _buildButton('Perfil', MyProfile(), context),
                _buildButton('Prueba pulsera', MyPulsera(), context),
            ],
      )),
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