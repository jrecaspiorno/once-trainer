import 'package:flutter/material.dart';
import 'package:flutterapp/Perfil/Dolencias.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';

class MyProfile extends StatelessWidget {
  List<Ejercicio> ejercicios;

  MyProfile(List<Ejercicio> ejercicios){
    this.ejercicios = ejercicios;
  }
  MyProfile.fromMyProfile();
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
          title: Text('Perfil'),
          backgroundColor: Colors.indigo,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 20),
            MyData(),
            MyButtonType(),
          ]
        )
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
          const SizedBox(height: 20),
          _buildButton('Historial Actividades', MyProfile.fromMyProfile(), context),
          _buildButton('Historial Clínico', MyProfile.fromMyProfile(), context),
          _buildButton('Dolencias', Dolencias(), context),
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

class MyData extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset('images/avatar.jpg', width: 200, height: 200, fit: BoxFit.cover,),
          Text('Pepito Pérez', style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }
}