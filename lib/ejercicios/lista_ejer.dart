import 'package:flutter/material.dart';
import 'package:flutterapp/ejercicios/BuildEjercicio.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/EjercicioTiempo.dart';
import 'package:flutterapp/ejercicios/FactoriaEj.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:io';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Future<List<Ejercicio>> getEjercicios(BuildContext context) async {
      List<String> XMLS = List();
      List<Ejercicio> ejercicios = List();
      XMLS = ["AfirmacionNegacion.xml","Caminar.xml","CirculosCadera.xml","ElevacionBrazos.xml","EstrujarToalla.xml","LevantamientosLateralesMancuernas.xml","LevantarBotella.xml","LevantarseSilla.xml","MovimientoRodillas.xml","PlantaPechoMacnuernas.xml","PrensaHombroMancuernas.xml","RotacionTobillos.xml","SubirEscaleras.xml","VueloPechoMancuernas.xml"];
      for (int i = 0; i < XMLS.length; ++i) {
        String xmlS = await DefaultAssetBundle.of(context)
            .loadString("todos_ejercicios/" + XMLS[i]);
        List <Ejercicio> ejercicios = List();
        /*
        var ejDir = new Directory('todos_ejercicios/');
        ejDir.list(recursive: false, followLinks: false).listen((
            FileSystemEntity entity) {
          XMLS.add(entity.path);
        });
         */
        for (int i = 0; i < XMLS.length; ++i) {
          String xmlS = await DefaultAssetBundle.of(context).loadString(
              "todos_ejercicios/" + XMLS[i]);
          var file = xml.parse(xmlS);
          var tags = file.findAllElements("tag").map((element) {
            return element.text;
          }).toList();
          ejercicios.add(FactoriaEj.GenerateEj(file));
        }
        return ejercicios;
      }
    }

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
            title: Text('Lista Ejercicios'),
            backgroundColor: Colors.indigo,
          ),
          extendBodyBehindAppBar: false,
          body: Container(
            child: FutureBuilder(
              future: getEjercicios(context),
              builder: (context,data){
                if(data.hasData){
                  List<Ejercicio> ejercicios = data.data;
                  return ListView.builder(
                      padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                      itemCount: ejercicios.length,
                      itemBuilder: (context,index){
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                        );
                        return Flex(
                          mainAxisSize: MainAxisSize.min,
                          
                          direction: Axis.vertical,
                          textDirection: TextDirection.ltr,
                          verticalDirection: VerticalDirection.down,                          
                          children: [
                            SizedBox(height: 40),
                            SizedBox(
                              width: 270,
                              child: RaisedButton(
                                
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                autofocus: true,
                                onPressed: () {
                                final Ejercicio ejercicio = ejercicios[index];
                                Navigator.push(context,MaterialPageRoute(builder: (context) => (BuildEjercicio(ejercicio : ejercicio,)),
                                  ));
                                },
                                
                                color: Colors.indigo,
                                textColor: Colors.white,
                                padding: EdgeInsets.all(24.0),
                                child: Text(ejercicios[index].name, style: TextStyle( fontSize: 30), 
                                  textAlign: TextAlign.center, ),
                              ),
                            ),
                            
                            
                            //const SizedBox(height: 20),
                          ],
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







