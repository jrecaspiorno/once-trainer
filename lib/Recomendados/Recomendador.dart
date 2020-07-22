import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterapp/Data/HiveData/Recomendador/recomendaciones.dart';
import 'package:flutterapp/Data/HiveData/RecomendadorList/RecomList.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:flutterapp/ejercicios/Ejercicio.dart';
import 'package:flutterapp/ejercicios/FactoriaEj.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:quiver/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart' as xml;

class RecomendadorView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  List<Ejercicio> ejerciciosf = List();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    var state = context.watch<LoginState>();
    Multimap<String, String> auxmap = Multimap<String, String>();
    var ejercicios = Multimap<String, Ejercicio>();
    List<String> names = List();
    Box recomBox;
    Box recomListBox;
    Recomendacione z;
    SharedPreferences _prefs;

    Future init() async {
      recomBox = await Hive.openBox('recomendaciones');
      recomListBox = await Hive.openBox('recomlists');
      _prefs = await SharedPreferences.getInstance();
      final manifestContent =
          await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final Map<String, dynamic> manifesMap = json.decode(manifestContent);
      List<String> xmls = manifesMap.keys
          .where((key) => key.contains('todos_ejercicios'))
          .toList();
      for (int i = 0; i < xmls.length; ++i) {
        String xmlS = await DefaultAssetBundle.of(context).loadString(xmls[i]);
        var file = xml.parse(xmlS);
        //logica para seleccionar ej's
        var ej = FactoriaEj.GenerateEj(file);

        ejercicios.add(ej.grupoprincipal, ej);
        auxmap.add(ej.grupoprincipal, ej.name);
      }

      if (!_prefs.containsKey('ListaEjers'))
        auxmap.forEachKey((key, value) {
          var aux = RecomList(key, value, 0, 0);
          recomListBox.add(aux);
        });

      if (!_prefs.containsKey('ListaEjers')) _prefs.setBool('ListaEjers', true);
    }

    Future<List<Ejercicio>> ejs() async {
      await init();
      double media = 0;
      List<Ejercicio> ejerciciosf = List();
      var l = recomListBox.values;
      int i = 0;
      if (!_prefs.containsKey('hayCambio')) _prefs.setBool('hayCambio', false);
      if (!_prefs.getBool('hayCambio')) {
        l.forEach((element) {
          media += element.hechosTotales;
        });
        media /= l.length;
        l.forEach((element) {
          int resta = element.hechosTotales - 3;
          if (media >= (resta)) {
            var rng = Random();
            var listAux = element.ejercicios;
            int auxhechosLista = element.hechosLista;
            int auxhechosTotal = element.hechosTotales;
            if (listAux.length == auxhechosLista) auxhechosLista = 0;
            int pos = rng.nextInt(listAux.length - auxhechosLista);
            var name = listAux[pos];
            Ejercicio ej;

            var x = ejercicios.asMap()[element.tipo].toList();
            int j = 0;
            while (j < x.length && ej == null) {
              if (x[j].name == name) {
                ej = x[j];
              }
              ++j;
            }
            listAux.removeAt(pos);
            listAux.add(name);
            auxhechosLista++;
            //TODO quitar hechos totales
            auxhechosTotal++;
            ejerciciosf.add(ej);
            names.add(ej.name);
            recomListBox.putAt(
                i,
                RecomList(
                    element.tipo, listAux, auxhechosLista, auxhechosTotal));
          }
          ++i;
        });
        _prefs.setBool('hayCambio', true);
        _prefs.setStringList("recomendados", names);
      } else {
        List<Ejercicio> val = ejercicios.values.toList();
        names = _prefs.getStringList('recomendados');
        names.forEach((element) {
          int i = 0;
          bool ok = false;
          while (i < val.length && !ok) {
            if (val[i].name == element) {
              ejerciciosf.add(val[i]);
              ok = true;
            }
            ++i;
          }
        });
      }
      return ejerciciosf;
    }

    return Scaffold(
      body: FutureBuilder(
          future: ejs(),
          builder: (_, data) {
            List<Ejercicio> ejercicios = data.data;
            if (ejercicios != null) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: ejercicios.length,
                      itemBuilder: (_, index) {
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                autofocus: true,
                                onPressed: () => _navigationService.replaceView(
                                    route.EjercicioPage,
                                    arguments: ejercicios[index]),
                                color: Colors.indigo,
                                textColor: Colors.white,
                                padding: EdgeInsets.all(24.0),
                                child: Text(
                                  ejercicios[index].name,
                                  style: TextStyle(fontSize: 30),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            //const SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: 270,
                        height: 10,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          autofocus: true,
                          onPressed: () async {
                            _prefs.setBool('hayCambio', false);
                            _navigationService.goBack();
                          },
                          color: Colors.indigo,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(24.0),
                          child: Text(
                            'Sesion Completada',
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
