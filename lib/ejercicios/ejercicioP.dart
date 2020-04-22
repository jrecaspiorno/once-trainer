import 'package:flutter/material.dart';

import 'ejercicioXML.dart';

class MyEjercicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildS
    return MaterialApp(
      title: 'App actividad física',
      home: Scaffold( // Widget con app prediseñada, esquema
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Ejercicio Ejemplo 1'),
          ),
          body: ListView(
              children: [
                const SizedBox(height: 10),
                MyEjercicioCrono(),
                imprimeEjer(),
              ]
          )
      ),
    );
  }
}

class MyEjercicio1 extends StatelessWidget {
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
            title: Text('Ejercicio Ejemplo 1'),
          ),
          body: ListView(
              children: [
                const SizedBox(height: 10),
                MyEjercicioCrono(),
                Text('Numero de Series: 3'),
                Text('Tiempo: 50"'),
                Text('Aqui viene la descripcion del ejercicio 1'),
              ]
          )
      ),
    );
  }
}

class MyEjercicio2 extends StatelessWidget {
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
            title: Text('Ejercicio Ejemplo 2'),
          ),
          body: ListView(
              children: [
                const SizedBox(height: 10),
                // MyEjercicioInfo(),
                Text('Numero de Series: 3'),
                Text('Numero de Repeticiones: 10'),
                Text('Aqui viene la descripcion del ejercicio 2'),
              ]
          )
      ),
    );
  }
}

class MyEjercicio3 extends StatelessWidget {
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
            title: Text('Ejercicio Ejemplo 3'),
          ),
          body: ListView(
              children: [
                const SizedBox(height: 10),
                MyEjercicioCrono(),
                Text('Aqui viene la descripcion del ejercicio 3'),
              ]
          )
      ),
    );
  }
}

class MyEjercicioCrono extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      // Coronometro
    );
  }
}