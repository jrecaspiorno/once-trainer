import 'package:flutter/material.dart';
import 'package:flutterapp/ejercicios/BuildEjercicio.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:xml/xml.dart' as xml;

import 'ejercicios/ejercicioP.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Future<List<Ejercicio>> getEjercicios(BuildContext context)async{
    String xmlS = await DefaultAssetBundle.of(context).loadString("todos_ejercicios/Ejercicios.xml");
    var file = xml.parse(xmlS);
    var elements = file.findAllElements("ejercicio");
    return elements.map((elements){
      return Ejercicio(elements.findElements("name").first.text
          , elements.findElements("time").first.text
          , elements.findElements("description").first.text
          ,  int.parse(elements.findElements("calories").first.text));
    }).toList();
    }

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
          ),
          body: Container(
            child: FutureBuilder(
              future: getEjercicios(context),
              builder: (context,data){
                if(data.hasData){
                  List<Ejercicio> ejercicios = data.data;
                  return ListView.builder(
                      itemCount: ejercicios.length,
                      itemBuilder: (context,index){
                        return RaisedButton(
                          onPressed: () {
                            final Ejercicio ejercicio = ejercicios[index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => (BuildEjercicio(ejercicio : ejercicio,)),
                            ));
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(24.0),
                          child: Text(ejercicios[index].name, style: TextStyle(fontSize: 30)),
                        );
                      },

                  );
                }
                else{
                  return Center(child: CircularProgressIndicator(),);
                }
              }

            ),
          )
      ),
    );
  }
}

class MyListType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          _buildEjer('Ejercicio Ejemplo XML', MyEjercicio(), context),
          _buildEjer('Ejercicio Ejemplo 1', MyEjercicio1(), context),
          _buildEjer('Ejercicio Ejemplo 2', MyEjercicio2(), context),
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


