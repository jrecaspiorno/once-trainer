import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/ejercicios/BuildEjercicio.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/FactoriaEj.dart';
import 'package:provider/provider.dart';
import 'package:xml/xml.dart' as xml;
class MyRecomList extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final database = Provider.of<AppDatabase>(context);
    Future<List<Ejercicio>> getEjercicios(BuildContext context) async {
      List<String> XMLS = List();
      List<Ejercicio> ejercicios = List();
      XMLS = ["Caminar.xml", "Ej1.xml"];
      List<Restriccione> Tags = await database.restriccionesDAO.resActivas();
      for (int i = 0; i < XMLS.length; ++i) {
        String xmlS = await DefaultAssetBundle.of(context)
            .loadString("todos_ejercicios/" + XMLS[i]);
        var file = xml.parse(xmlS);
        Ejercicio ej =FactoriaEj.GenerateEj(file);
        bool ok = true;
        Tags.forEach((tag) {
          ej.tags.forEach((tagej) {
            if(tag.tipo == tagej) {ok = false; return;}
          });
          if(ok == false) return;
        });
        if(ok)
          ejercicios.add(ej);
      }

      return ejercicios;
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
            title: Text('Ejercicios Recomendados'),
            backgroundColor: Colors.indigo,
          ),
          extendBodyBehindAppBar: false,
          body: Container(
            child: FutureBuilder(
                future: getEjercicios(context),
                builder: (context, data) {
                  if (data.hasData) {
                    List<Ejercicio> ejercicios = data.data;
                    return ListView.builder(
                      padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                      
                      itemCount: ejercicios.length,
                      itemBuilder: (context, index) {
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                        );
                        return Column(
                          children: [
                            const SizedBox(height: 40),
                            RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

                              onPressed: () {
                                final Ejercicio ejercicio = ejercicios[index];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => (BuildEjercicio(
                                        ejercicio: ejercicio,
                                      )),
                                    ));
                              },
                              color: Colors.indigo,
                              textColor: Colors.white,
                              padding: EdgeInsets.all(24.0),
                              child: Text(ejercicios[index].name,
                                  style: TextStyle(fontSize: 30)),
                            ),
                            //const SizedBox(height: 20),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )),
    );
  }
}
