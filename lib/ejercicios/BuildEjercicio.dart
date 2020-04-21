

import 'package:flutter/material.dart';

import 'Ejercicio.dart';



class BuildEjercicio extends StatelessWidget {
  Ejercicio ejercicio;

  BuildEjercicio( {Ejercicio ejercicio}){
    this.ejercicio = ejercicio;
  }

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
              title: Text(ejercicio.name),


            ),
            body: ListView(
                children: [
                  const SizedBox(height: 10),
                  MyEjercicioCrono(),
                  ListTile(
                    title: Text(
                      "Tiempo: "+ejercicio.time,
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ), ),

                  ),
                  Text("Descripcion: " + ejercicio.description, style: TextStyle(
                    fontSize: 20,
                  ),)
                ]
            )
        ),
    );
  }


  ListTile EjercioG(Ejercicio ejercicio) {
    return ListTile(
      title: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: ejercicio.name,
        ),
      ),
    );
  }


}
class MyEjercicioCrono extends StatelessWidget {
  @override
  Widget build(BuildContext context) {// TODO: implement build
    return Row(
    // Coronometro
    );
  }
}